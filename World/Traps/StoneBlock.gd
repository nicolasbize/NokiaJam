extends Node2D

onready var animation_player = $AnimationPlayer

func activate():
	animation_player.play("Activate")
