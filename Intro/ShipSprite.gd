extends Sprite

func shake() -> void:
	position = Vector2(randi() % 2 - 1, randi() % 2 - 1)
