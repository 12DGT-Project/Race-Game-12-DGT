extends Area3D

@onready var aura_point_menu = $"../Aura Point Menu"
@onready var aura_point_timer_bar = $"../Player/Aura Point Timer Bar"
@onready var aura_point_counter = $"../Player/Aura Point Counter"
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D


var rotation_speed : float = 1.75
var ground_height_y : float = 2.17

var checkpoint_normal = [Vector3(15.71, ground_height_y, 65.087)]
var checkpoint_rotate = [Vector3(80.261, ground_height_y, 57.176)] 

<<<<<<< Updated upstream
=======
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
>>>>>>> Stashed changes

func _ready() -> void:
	add_to_group("CheckPoints")

func _on_body_entered(_body: Node3D) -> void:
	var isPlayer = get_tree().get_first_node_in_group("Player")
	if isPlayer:
		if Global.timer_is_running == false: 
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
			#if global_position in checkpoint_normal:
				#otate_y(deg_to_rad(90))
			var position_choice : int = randi_range(0,1)
			if position_choice == 0:
				global_position = checkpoint_normal[randi_range(0, (checkpoint_normal.size() - 1))]
			else:
				global_position = checkpoint_rotate[randi_range(0, (checkpoint_rotate.size() - 1))]
				#rotate_y(deg_to_rad(90))

func _process(delta: float) -> void:
	mesh_instance_3d.rotate_y(rotation_speed * delta)
