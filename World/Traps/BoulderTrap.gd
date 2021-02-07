extends Node

onready var animation_player = $AnimationPlayer

func _on_PlayerTrigger_area_entered(area):
	animation_player.play("BoulderFalling")
