extends CanvasLayer

onready var sign_reading = $SignReading

var is_paused := false

func toggle_sign(text) -> void:
	sign_reading.visible = !sign_reading.visible
	is_paused = sign_reading.visible
	print(is_paused)

func _on_Sign_read(text):
	toggle_sign(text)
