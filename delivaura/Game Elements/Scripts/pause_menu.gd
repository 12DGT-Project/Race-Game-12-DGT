extends CanvasLayer
@onready var controls: Label = $Controls
@onready var blurry_bg: ColorRect = $"Blurry BG"
@onready var main_map: Control = $"../Main Map"


func _on_resume_pressed():
	Global.PauseMenu(self)

func _on_display_controls_pressed():
	controls.show()

func _on_close_controls_pressed() -> void:
	controls.hide()

func _on_display_map_pressed() -> void:
	main_map.show()

func _on_close_map_pressed() -> void:
	main_map.hide()

func _on_quit_pressed():
	get_tree().quit()
