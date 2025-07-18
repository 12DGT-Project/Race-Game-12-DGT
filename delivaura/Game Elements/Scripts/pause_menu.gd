extends CanvasLayer
@onready var pause_menu = $"."
@onready var controls: Label = $Controls


func _on_resume_pressed():
	Global.PauseMenu(pause_menu)

func _on_display_controls_pressed():
	controls.show()

func _on_quit_pressed():
	get_tree().quit()

func _on_close_controls_pressed() -> void:
	controls.hide()
