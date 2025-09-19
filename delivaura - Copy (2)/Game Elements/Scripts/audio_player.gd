extends AudioStreamPlayer

const main_theme = preload("res://Assets (DO NOT MOVE)/Audio/Delivaura_Menu_Theme.mp3")
const background_theme = preload("res://Assets (DO NOT MOVE)/Audio/deliavaura gameplay theme.mp3")

func _play_music(music: AudioStream, volume : float = 0.0) -> void:
	pass
	if stream == music:
		return
	else:
		stream = music
	volume_db = volume
	play()

func _play_menu_music():
	_play_music(main_theme)

func _play_level_music():
	_play_music(background_theme)
	
	
func _play_fx(Stream : AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = Stream
	fx_player.name = "FX Player"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	
	
