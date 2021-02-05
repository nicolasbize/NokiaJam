extends Node2D

var speed:int = 30
var dying:bool = false

onready var animation_player = $AnimationPlayer

func _process(delta) -> void:
	if not dying:
		translate(Vector2(speed, 0) * delta)

func explode() -> void:
	animation_player.play("Explode")
	dying = true
	
func destroy() -> void:
	queue_free()
