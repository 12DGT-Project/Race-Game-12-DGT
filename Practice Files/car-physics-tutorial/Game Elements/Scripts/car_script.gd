extends Node3D


@onready var Ball: RigidBody3D = $Ball
@onready var CarBody: Node3D = $"Car Body"
@onready var FLWheel: MeshInstance3D = $"Car Body/Model/wheel-front-left"
@onready var FRWheel: MeshInstance3D = $"Car Body/Model/wheel-front-right"
@onready var MeshBody: MeshInstance3D = $"Car Body/Model/body"

var acceleration = 70.0
var steering = 12.0
var turn_speed = 5.0
var body_tilt = 30

var speed_input = 0
var rotate_input = 0

func _physics_process(_delta: float) -> void:
	CarBody.transform.origin - Ball.transform.origin
	Ball.apply_central_force(-CarBody.global_transform.basis.z * speed_input)


func _process(_delta: float) -> void:
	speed_input = (Input.get_action_strength("Accelerate") - Input.get_action_strength("Brake")) * acceleration
	rotate_input = deg_to_rad(steering) * (Input.get_action_strength("SteerLeft") - Input.get_action_strength("SteerRight"))
	FRWheel.rotation.y = rotate_input
	FLWheel.rotation.y = rotate_input
	
	if Ball.linear_velocity.length() > 0.75:
		RotateCar(_delta)

func RotateCar(delta : float) -> void:
	var new_basis = CarBody.global_transform.basis.rotated(CarBody.global_transform.basis.y, rotate_input)
	CarBody.global_transform.basis = CarBody.global_transform.basis.slerp(new_basis, turn_speed * delta)
	CarBody.global_transform = CarBody.global_transform.orthonormalized()
	var t = -rotate_input * Ball.linear_velocity.length() / body_tilt
	MeshBody.rotation.z = lerp(MeshBody.rotation.z, t, 10 * delta)
