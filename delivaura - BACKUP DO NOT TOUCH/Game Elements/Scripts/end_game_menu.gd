extends CanvasLayer
@onready var credits: Label = $Credits


func _on_restart_game_pressed() -> void:
	Global.total_aura_points = 0
	get_tree().change_scene_to_file("res://Game Elements/Scenes/mainmenu.tscn")

func _on_display_credits_pressed() -> void:
	credits.show()

func _on_close_credits_pressed() -> void:
	credits.hide()

func _on_quit_pressed() -> void:
	get_tree().quit()
