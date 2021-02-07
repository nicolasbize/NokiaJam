class_name MenuItem
extends Control

onready var animation_player = $AnimationPlayer

func select() -> void:
	animation_player.play("Selected")

func deselect() -> void:
	animation_player.play("Idle")
