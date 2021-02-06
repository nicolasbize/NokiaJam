extends Node2D

export (bool) var is_pressed = false

onready var timer := $Timer

var original_location := Vector2.ZERO

signal press_change(pressed)

func _ready() -> void:
	original_location = global_position

func _process(delta) -> void:
	global_position = original_location
	if is_pressed:
		global_position += Vector2(0, 1)

func _on_Area2D_area_entered(area):
	timer.start()

func _on_Timer_timeout():
	if not is_pressed:
		is_pressed = true
		emit_signal("press_change", is_pressed)

func _on_Area2D_area_exited(area):
	timer.stop()
	is_pressed = false
	emit_signal("press_change", is_pressed)
