extends "res://Inventory/Collectible.gd"

onready var hint_pointer = $HintPointer
onready var animation_player = $AnimationPlayer

func _on_PlayerTrigger_area_entered(area):
	animation_player.stop(true)
	hint_pointer.visible = false
