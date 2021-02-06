## A save point for the player
## Not that a good player would actually need any for this game...
class_name Checkpoint
extends Node2D

export(bool) var hidden = false

onready var sprite = $Sprite

signal checkpoint

var checked:bool = false

func _ready() -> void:
	if hidden:
		sprite.visible = false

func _on_PlayerTrigger_area_entered(area):
	if not checked:
		checked = true
		sprite.frame = 1
		emit_signal("checkpoint", self)
