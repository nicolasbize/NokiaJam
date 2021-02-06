## Projectiles can either be thrown by World props or by enemies
## The player might at some point? Nah probably not :)
class_name Projectile
extends Node2D

var velocity:Vector2 = Vector2.ZERO
var dying:bool = false

onready var animation_player = $AnimationPlayer

func _process(delta) -> void:
	if not dying:
		position += velocity * delta
		
func explode() -> void:
	animation_player.play("Explode")
	dying = true
	
func destroy_game_object() -> void:
	queue_free()

func _on_HitBox_body_entered(body):
	explode()
