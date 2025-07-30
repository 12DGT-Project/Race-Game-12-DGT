extends AudioStreamPlayer

const main_theme = preload("res://Assets (DO NOT MOVE)/Audio/Delivaura_Menu_Theme.mp3")

func _play_music(music: AudioStream, volume : float = 0.0) -> void:
	pass
	if stream == music:
		return
	else:
		stream = music
	volume_db = volume
	play()

func _play_music_level():
	_play_music(main_theme)
