extends Node2D

onready var animation_player = $AnimationPlayer
onready var path_follow_2d = $Path2D/PathFollow2D

func activate():
	animation_player.play("Activate")

func reset():
	animation_player.play("Reset")
