extends Node2D

export (float) var delay_start := 0.0

onready var timer = $StartTimer
onready var animation_player = $AnimationPlayer

func _ready() -> void:
	timer.start(delay_start)

func _on_StartTimer_timeout():
	animation_player.play("Glide")
