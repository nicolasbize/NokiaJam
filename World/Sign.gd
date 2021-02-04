extends Sprite

onready var animation_player := $AnimationPlayer

export (String) var text := ""

func _on_Area2D_body_entered(body):
	animation_player.play("Hover")
	
func _on_Area2D_body_exited(body):
	animation_player.play("Idle")
