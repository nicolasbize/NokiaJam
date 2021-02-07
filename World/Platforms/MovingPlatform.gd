extends Node2D

export(float) var delay_start := 0.0
export(NodePath) var switch = null

onready var timer = $StartTimer
onready var animation_player = $AnimationPlayer

func _ready() -> void:
	if switch == null:
		timer.start(delay_start)
	else:
		get_node(switch).connect("status_change", self, "_on_Switch_status_change")

func _on_Switch_status_change(pressed):
	timer.start(delay_start)

func _on_StartTimer_timeout():
	animation_player.play("Glide")
