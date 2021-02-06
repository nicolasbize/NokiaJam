extends Node2D

onready var animation_player = $AnimationPlayer
onready var path_follow_2d = $Path2D/PathFollow2D

func activate() -> void:
	animation_player.play("Activate")

func activate_slow() -> void:
	animation_player.play("ActivateSlow")

func reset() -> void:
	animation_player.play("Reset")
