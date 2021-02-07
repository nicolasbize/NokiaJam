extends Node2D

onready var animation_player := $AnimationPlayer
onready var world_collision_shape := $WorldCollision/CollisionShape2D

func stop():
	animation_player.play("Idle")
	world_collision_shape.disabled = false
