extends Node3D

@onready var Ball: RigidBody3D = $Ball
@onready var CarBody: Node3D = $"Car Body"
@onready var FLWheel: MeshInstance3D = $"Car Body/Model/wheel-front-left"
@onready var FRWheel: MeshInstance3D = $"Car Body/Model/wheel-front-right"
@onready var MeshBody: MeshInstance3D = $"Car Body/Model/body"
@onready var drift_timer: Timer = $DriftTimer
@onready var boost_timer: Timer = $BoostTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var needle: Sprite2D = $"Car Body/Speedometer/Needle"

var acceleration = 90.0
var steering = 20.0
var turn_speed = 5.0
var body_tilt = 30

var speed_input = 0
var rotate_input = 0

var Drifting = false
var DriftDirection = 0
var MinimumDrift = false
var Boost = 1.0
var DriftBoost = 2.5

# Speedometer constants
const MAX_SPEED = 50.0  # Adjust based on your car's max speed
const MIN_ANGLE = -150  # Needle position at 0 speed
const MAX_ANGLE = 150   # Needle position at max speed
const ROTATION_RANGE = MAX_ANGLE - MIN_ANGLE  # Total needle movement range

func _ready() -> void:
	add_to_group("Player")
	needle.rotation_degrees = MIN_ANGLE  # Initialize at zero position

func _physics_process(_delta: float) -> void:
	# Update car body position to match ball position
	CarBody.global_transform.origin = Ball.global_transform.origin
	# Apply force in the direction the car is facing
	Ball.apply_central_force(-CarBody.global_transform.basis.z * speed_input * Boost)

func _process(delta: float) -> void:
	global_position.normalized()
	speed_input = (Input.get_action_strength("Accelerate") - Input.get_action_strength("Brake")) * acceleration
	rotate_input = deg_to_rad(steering) * (Input.get_action_strength("SteerLeft") - Input.get_action_strength("SteerRight"))
	FRWheel.rotation.y = rotate_input
	FLWheel.rotation.y = rotate_input
	
	if Input.is_action_just_pressed("Drift") and not Drifting and rotate_input != 0 and speed_input > 0:
		StartDrift()
	
	if Drifting:
		var DriftAmount = 0
		DriftAmount += Input.get_action_strength("SteerLeft") - Input.get_action_strength("SteerRight")
		DriftAmount *= deg_to_rad(steering * 0.55)
		rotate_input = DriftDirection + DriftAmount
	
	if Drifting and (Input.is_action_just_released("Drift") or speed_input < 1):
		StopDrift()
	
	if Ball.linear_velocity.length() > 0.75:
		RotateCar(delta)
		
	_update_speedometer()  # Update the speedometer each frame
	
func _update_speedometer():
	# Get actual speed from ball's linear velocity
	var current_speed = Ball.linear_velocity.length()
	
	# Calculate speed ratio (0.0 to 1.0)
	var speed_ratio = min(current_speed / MAX_SPEED, 1.0)
	
	# Map speed ratio to needle rotation angle
	var target_angle = MIN_ANGLE + (ROTATION_RANGE * speed_ratio)
	
	# Smoothly interpolate needle rotation
	needle.rotation_degrees = lerp(needle.rotation_degrees, target_angle, 0.1)

func RotateCar(delta : float) -> void:
	var new_basis = CarBody.global_transform.basis.rotated(CarBody.global_transform.basis.y, rotate_input)
	CarBody.global_transform.basis = CarBody.global_transform.basis.slerp(new_basis, turn_speed * delta)
	CarBody.global_transform = CarBody.global_transform.orthonormalized()
	var t = -rotate_input * Ball.linear_velocity.length() / body_tilt
	MeshBody.rotation.z = lerp(MeshBody.rotation.z, t, 10 * delta)

func StartDrift():
	Drifting = true
	animation_player.play("Hop")
	MinimumDrift = false
	DriftDirection = rotate_input
	drift_timer.start()

func StopDrift():
	if MinimumDrift:
		Boost = DriftBoost
		boost_timer.start()
	animation_player.play("Zoom Out")
	Drifting = false
	MinimumDrift = false
	
func _on_drift_timer_timeout() -> void:
	if Drifting:
		MinimumDrift = true
	
func _on_boost_timer_timeout() -> void:
	Boost = 1.0
	animation_player.play("Zoom In")
	MinimumDrift = false
