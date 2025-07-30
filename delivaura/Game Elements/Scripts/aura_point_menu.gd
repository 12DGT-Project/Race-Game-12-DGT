extends CanvasLayer
@onready var aura_point_menu = $"."
@onready var rules = $Rules
@onready var aura_point_timer_bar = $"../Player/Aura Point Timer Bar"

func _on_start_aura_challenge_pressed():
	aura_point_menu.hide()
	Global.PauseMenu(aura_point_menu)
	Global.aura_point_timer.start(Global.timer_start_value)
	Global.timer_is_running = true
	aura_point_timer_bar.show()
	

func _on_info_and_rules_pressed():
	rules.show()

func _on_cancel_challenge_pressed():
	aura_point_menu.hide()
	Global.PauseMenu(aura_point_menu)

func _on_close_rules_pressed():
	rules.hide()
