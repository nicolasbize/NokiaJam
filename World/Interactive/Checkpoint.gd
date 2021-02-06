extends Node2D

onready var sprite = $Sprite

signal checkpoint

var checked:bool = false

func _on_Area2D_body_entered(_body) -> void:
	if not checked:
		checked = true
		sprite.frame = 1
		emit_signal("checkpoint", self)
