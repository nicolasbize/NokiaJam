extends Camera2D
var shake:float = 0.0

onready var timer := $Timer

func _process(_delta) -> void:
	offset_h = rand_range(-shake, shake)
	offset_v = rand_range(-shake, shake)

func screen_shake(amount:float, duration:float) -> void:
	shake = amount
	timer.wait_time = duration
	timer.start()

func _on_Timer_timeout() -> void:
	shake = 0
