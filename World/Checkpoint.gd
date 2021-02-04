extends Node2D

onready var sprite = $Sprite

signal checkpoint

func _on_Area2D_body_entered(body):
	sprite.frame = 1
	emit_signal("checkpoint", self)
