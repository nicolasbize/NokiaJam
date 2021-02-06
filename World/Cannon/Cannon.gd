extends Node2D

enum DIRECTION {LEFT = -1, RIGHT = 1}

const CannonBall = preload("res://World/Cannon/CannonBall.tscn")

export (int) var cooldown_time = 3
export (DIRECTION) var direction = DIRECTION.RIGHT

onready var sprite = $Sprite
onready var timer = $Timer
onready var switch = $Switch

var can_fire:bool = true

func _process(_delta) -> void:
	sprite.flip_h = direction == DIRECTION.LEFT

func _on_Switch_pressed(_switch) -> void:
	if can_fire:
		fire()
		
func fire() -> void:
	can_fire = false
	var ball := CannonBall.instance()
	get_parent().add_child(ball)
	get_parent().move_child(ball, 0)
	ball.global_position = sprite.global_position + Vector2(0, -1)
	if direction == DIRECTION.LEFT:
		ball.speed = -ball.speed
	timer.start(cooldown_time)

func _on_Timer_timeout() -> void:
	can_fire = true
	switch.reset()
	
