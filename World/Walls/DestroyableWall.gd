## Use Cannon Balls to destroy this
class_name DestroyableWall
extends StaticBody2D

onready var animation_player = $AnimationPlayer

func _on_HurtBox_hit(damage) -> void:
	animation_player.play("Explode")

func destroy_game_object() -> void:
	queue_free()
