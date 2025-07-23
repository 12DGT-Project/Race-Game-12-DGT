extends Node

var aura_point_timer : Timer = Timer.new()
var timer_start_value : int = 90
var timer_is_running : bool = false
var game_paused : bool = false
var total_aura_points : int = 0


func PauseMenu(MENU):
	if game_paused:
		MENU.hide()
		#get_tree().paused = false
		Engine.time_scale = 1
	else:
		MENU.show()
		#get_tree().paused = true
		Engine.time_scale = 0
		
	game_paused = !game_paused

func _ready():
	add_child(aura_point_timer)
	aura_point_timer.timeout.connect(_on_aura_point_timer_timeout)	

func Initialise_Timer_Bar(TIMER : ProgressBar):
	TIMER.max_value = timer_start_value
	TIMER.value = timer_start_value

func _on_aura_point_timer_timeout():
	timer_is_running = false
