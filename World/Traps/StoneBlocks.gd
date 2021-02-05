extends Node

onready var animation_player = $AnimationPlayer

func _on_Switch_pressed():
	animation_player.play("Activate")
