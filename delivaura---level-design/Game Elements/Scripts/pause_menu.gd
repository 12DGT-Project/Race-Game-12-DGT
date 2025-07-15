extends CanvasLayer
@onready var pause_menu = $"."


func _on_resume_pressed():
	Global.PauseMenu(pause_menu)

func _on_display_controls_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()
