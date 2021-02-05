extends "res://World/Sign.gd"

signal pressed(switch)

export (bool) var SINGLE_USE = true
var is_pressed := false

func switch() -> void:
	if SINGLE_USE and not is_pressed:
		is_pressed = true
		is_interactive = false
		animation_player.play("Idle")
		emit_signal("pressed", self)
		frame = 1
	elif not SINGLE_USE:
		is_pressed = !is_pressed
		if is_pressed:
			frame = 1
			emit_signal("pressed", self)
		else:
			frame = 0
			emit_signal("pressed", self)

func reset() -> void:
	is_pressed = false
	is_interactive = true
	frame = 0
	
