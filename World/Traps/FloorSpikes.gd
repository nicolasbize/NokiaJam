## FloorSpikes, one of my all time favorites
class_name FloorSpikes
extends Sprite

func _on_PlayerTrigger_area_entered(area):
	frame = 1

func _on_PlayerTrigger_area_exited(area):
	frame = 0
