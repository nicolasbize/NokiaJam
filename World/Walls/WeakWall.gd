extends KinematicBody2D

onready var animation_player = $AnimationPlayer

func _on_HurtArea_area_entered(area) -> void:
	animation_player.play("Explode")
	area.get_owner().explode()

func destroy() -> void:
	queue_free()
