extends Node

onready var animation_player = $AnimationPlayer

func _on_Switch_pressed(switch):
	animation_player.play("Activate")
