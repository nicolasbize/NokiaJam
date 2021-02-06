extends Node2D

const CannonBall = preload("res://Projectiles/CannonBall.tscn")

export(int) var cooldown_time = 3
export(int) var bullet_speed = 20
export(NodePath) var switch = null

onready var nozzle = $Sprite/Nozzle
onready var timer = $Timer

var can_fire:bool = true

func _ready() -> void:
	if switch == null:
		timer.start(cooldown_time)
	else:
		get_node(switch).connect("status_change", self, "_on_Switch_status_change")

func _on_Switch_status_change(pressed) -> void:
	fire()
		
func fire() -> void:
	var ball := CannonBall.instance()
	get_parent().add_child(ball)
	get_parent().move_child(ball, 0)
	ball.global_position = nozzle.global_position
	ball.velocity = Vector2.UP.rotated(rotation) * bullet_speed
	timer.start(cooldown_time)

func _on_Timer_timeout() -> void:
	if switch == null:
		fire()
