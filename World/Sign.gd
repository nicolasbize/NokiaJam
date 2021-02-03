extends Sprite

onready var animation_player := $AnimationPlayer
onready var sprite := $Sprite

var can_trigger := false

signal read

func _on_Area2D_body_entered(body):
	animation_player.play("Hover")
	can_trigger = true
	
func _on_Area2D_body_exited(body):
	animation_player.play("Idle")
	can_trigger = false

func _process(delta) -> void:
	if Input.is_action_just_pressed("ui_down"):
		emit_signal("read", "hello")
