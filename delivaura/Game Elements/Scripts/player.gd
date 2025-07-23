extends Node3D

@onready var aura_point_timer_bar = $"Aura Point Timer Bar"
@onready var aura_point_counter = $"Aura Point Counter"
@onready var player_coords: Label = $"Player Coordinates"
@onready var city: Node3D = $".."


var base_label = "Total Aura Points: %s"

func _ready():
	Global.Initialise_Timer_Bar(aura_point_timer_bar)

func _process(_delta):
	player_coords.text = str(Global.getglobal_position)
	aura_point_timer_bar.value = Global.aura_point_timer.time_left
	aura_point_counter.text = base_label % Global.total_aura_points
	if Global.timer_is_running == false:
		aura_point_timer_bar.hide()
