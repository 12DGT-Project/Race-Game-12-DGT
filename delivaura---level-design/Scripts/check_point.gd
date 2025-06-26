extends Area3D

@export var HasEntered = false

func _ready() -> void:
	add_to_group("CheckPoints")

func _on_body_entered(_body: Node3D) -> void:
	var isPlayer = get_tree().get_first_node_in_group("Player")
	if isPlayer: 
		HasEntered = true
		print("The Player Has Entered.")
