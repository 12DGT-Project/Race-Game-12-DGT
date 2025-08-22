extends Area3D

@onready var aura_point_menu = $"../Aura Point Menu"
@onready var aura_point_timer_bar = $"../Player/Aura Point Timer Bar"
@onready var aura_point_counter = $"../Player/Aura Point Counter"
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D


var rotation_speed : float = 1.75

var checkpoint_pos = [Vector3(80.261, 2.195, 57.176), Vector3(15.71, 2.17, 65.087)]

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
			global_position = checkpoint_pos[randi_range(0, (checkpoint_pos.size() - 1))]
			pass

func _process(delta: float) -> void:
	mesh_instance_3d.rotate_y(rotation_speed * delta)
