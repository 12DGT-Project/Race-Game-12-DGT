extends CanvasLayer
@onready var sprint_information: Label = $"Sprint Information Text"

func _ready() -> void:
	AudioPlayer._play_music_level()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Game Elements/Scenes/City.tscn")
	AudioPlayer.stop()

func _on_information_pressed() -> void:
	sprint_information.show()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_close_information_pressed() -> void:
	sprint_information.hide()
