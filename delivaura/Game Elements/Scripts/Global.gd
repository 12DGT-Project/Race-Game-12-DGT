extends Node

var aura_point_timer : Timer = Timer.new()
var timer_start_value : int = 100
var timer_is_running : bool = false
var game_paused : bool = false
var total_aura_points : int = 90

func _physics_process(delta):
	# Guard clause: Skip calculations when paused
	if delta == 0:
		return

func _process(delta: float) -> void:
	if total_aura_points >= 100:
		get_tree().change_scene_to_file("res://Game Elements/Scenes/end_game_menu.tscn")

func PauseMenu(MENU : CanvasLayer):
	MENU.process_mode = Node.PROCESS_MODE_ALWAYS
	
	if game_paused:
		get_tree().paused = false
		MENU.hide()
		#Engine.time_scale = 1
	else:
		get_tree().paused = true
		MENU.show()
		#Engine.time_scale = 0
		
	game_paused = !game_paused

func _ready():
	add_child(aura_point_timer)
	aura_point_timer.timeout.connect(_on_aura_point_timer_timeout)	

func Initialise_Timer_Bar(TIMER : ProgressBar):
	TIMER.max_value = timer_start_value
	TIMER.value = timer_start_value

func _on_aura_point_timer_timeout():
	timer_is_running = false
