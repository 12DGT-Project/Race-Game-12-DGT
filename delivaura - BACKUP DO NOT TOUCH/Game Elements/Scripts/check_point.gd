extends Area3D

@onready var aura_point_menu = $"../Aura Point Menu"
@onready var aura_point_timer_bar = $"../Player/Aura Point Timer Bar"
@onready var aura_point_counter = $"../Player/Aura Point Counter"
@onready var checkpoint_label: MeshInstance3D = $"Checkpoint Label"
@onready var parcel_sprite: MeshInstance3D = $ParcelSprite


var rotation_speed : float = 1.75
const CHECKPOINT_HEIGHT = 2.17

var checkpoint_pos = [
	Vector3(71.29, CHECKPOINT_HEIGHT, 74.09), 
	Vector3(15.71, CHECKPOINT_HEIGHT, 74.09),
	Vector3(70.547, CHECKPOINT_HEIGHT, 101.001),
	Vector3(130.23, CHECKPOINT_HEIGHT, -9.832),
	Vector3(100.1, CHECKPOINT_HEIGHT, -10.394),
	Vector3(-70.618, CHECKPOINT_HEIGHT, -158.454),
	Vector3(-70.078, CHECKPOINT_HEIGHT, 10.579),
	Vector3(-100.944, CHECKPOINT_HEIGHT, 100.472),
	Vector3(90.712, CHECKPOINT_HEIGHT, 100.685),
	Vector3(67.648, CHECKPOINT_HEIGHT, -128.332)
	]

func _ready() -> void:
	add_to_group("CheckPoints")

func _on_body_entered(_body: Node3D) -> void:
	var isPlayer = get_tree().get_first_node_in_group("Player")
	if isPlayer:
		if Global.timer_is_running == false and Global.total_aura_points < 100: 
			print("The Player Has Entered.")
			Global.PauseMenu(aura_point_menu)
		else:
			Global.timer_is_running = false
			Global.aura_point_timer.stop()
			aura_point_timer_bar.hide()
			Global.Initialise_Timer_Bar(aura_point_timer_bar)
			Global.total_aura_points += 10

func _on_body_exited(_body: Node3D) -> void:
	var isPlayer = get_tree().get_first_node_in_group("Player")
	if isPlayer and Global.timer_is_running == true:
		var current_position : Vector3 = global_position
		while global_position == current_position:
			global_position = checkpoint_pos[randi_range(0, (checkpoint_pos.size() - 1))]
			pass

func _process(delta: float) -> void:
	checkpoint_label.rotate_y(rotation_speed * delta)
	parcel_sprite.rotate_y(rotation_speed * delta)
