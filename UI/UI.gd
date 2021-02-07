extends CanvasLayer

onready var sign_panel = $SignPanel
onready var sign_label = $SignPanel/SignLabel
onready var info_panel = $InfoPanel
onready var info_label = $InfoPanel/ColorRect/ColorRect2/InfoLabel
onready var screen_dissolver = $ScreenDissolver
onready var score_panel = $ScorePanel
onready var time_value = $ScorePanel/TimeValue
onready var death_value = $ScorePanel/DeathValue
onready var rank_value = $ScorePanel/RankValue

func _on_Player_start_reading(text:String) -> void:
	sign_label.text = text
	sign_panel.visible = true
	
func _on_Player_stop_reading() -> void:
	clear()

func show_score(deaths:int, time:int) -> void:
	clear()
	screen_dissolver.fade()
	yield(get_tree().create_timer(2), "timeout")
	var mins = int(time / 60)
	var secs = time - mins * 60
	time_value.text = "%d:%02d" % [mins, secs]
	death_value.text = str(deaths)
	var score := time + deaths * 10
	if score < 300:
		rank_value.text = "JEDI!"
	elif score < 400:
		rank_value.text = "MASTER"
	elif score < 500:
		rank_value.text = "PRO"
	elif score < 600:
		rank_value.text = "EXPERT"
	elif score < 700:
		rank_value.text = "NOVICE"
	score_panel.visible = true

func show_info(text) -> void:
	info_label.text = text
	info_panel.visible = true

func clear() -> void:
	sign_panel.visible = false
	info_panel.visible = false
