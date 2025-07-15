extends Node3D
@onready var pause_menu = $"Pause Menu"


func _process(_delta):
	if Input.is_action_just_pressed("Pause"):
		Global.PauseMenu(pause_menu)
