extends Sprite

func _on_Area2D_body_entered(body):
	frame = 1

func _on_Area2D_body_exited(body):
	frame = 0
