extends Sprite

export(bool) var is_shaking = true

onready var timer := $Timer

func shake() -> void:
	position = Vector2(randi() % 2 - 1, randi() % 2 - 1)

func _on_Timer_timeout() -> void:
	if is_shaking:
		shake()
		timer.start()
