class_name Sign
extends Sprite

onready var animation_player := $AnimationPlayer

export (String) var text := ""
export (bool) var is_interactive := true

func _on_Area2D_body_entered(body):
	if is_interactive:
		animation_player.play("Hover")
	
func _on_Area2D_body_exited(body):
	animation_player.play("Idle")
