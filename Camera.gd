extends Camera2D
var shake:float = 0.0

onready var timer := $Timer

func _process(delta):
	var h = rand_range(-shake, shake)
	offset_h = rand_range(-shake, shake)
	offset_v = rand_range(-shake, shake)

func screen_shake(amount:float, duration:float):
	shake = amount
	timer.wait_time = duration
	timer.start()

func _on_Timer_timeout():
	shake = 0
