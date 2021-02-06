extends Sprite

func _on_Area2D_body_entered(_body) -> void:
	frame = 1

func _on_Area2D_body_exited(_body) -> void:
	frame = 0
