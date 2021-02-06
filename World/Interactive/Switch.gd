## Switch Button that can be either pressed or released
class_name Switch
extends Sprite
signal status_change(pressed)

export(int) var reset_cooldown = 0
export(bool) var is_toggle = false
export(bool) var is_enabled = true
export(bool) var is_pressed = false
export(bool) var is_single_use = false
export(String) var data = ""

onready var hint_pointer = $HintPointer
onready var timer_reset = $TimerReset

func _process(delta) -> void:
	frame = 1 if is_pressed else 0

func use() -> void:
	var prev_state = is_pressed
	if is_enabled:
		if is_toggle:
			is_pressed = !is_pressed
		else:
			is_pressed = true
			if is_single_use:
				is_enabled = false
				hint_pointer.visible = false
			if reset_cooldown > 0:
				timer_reset.start(reset_cooldown)
	if is_pressed != prev_state:
		emit_signal("status_change", is_pressed)

func reset() -> void:
	is_pressed = false
	is_enabled = true

func _on_PlayerTrigger_area_entered(area):
	if is_enabled:
		hint_pointer.visible = true

func _on_PlayerTrigger_area_exited(area):
	hint_pointer.visible = false

func _on_PlayerTrigger_use(player):
	use()

func _on_TimerReset_timeout():
	reset()
