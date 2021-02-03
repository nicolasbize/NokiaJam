extends KinematicBody2D

export (int) var ACCELERATION = 512
export (int) var MAX_SPEED = 52
export (float) var FRICTION = 0.35
export (int) var GRAVITY = 220
export (int) var JUMP_FORCE = 80
export (int) var MAX_SLOPE_ANGLE = 46

var motion := Vector2.ZERO
var snap_vector := Vector2.ZERO
var just_jumped := false

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer

func _physics_process(delta) -> void:
	print(Ui.is_paused)
	if not Ui.is_paused:
		just_jumped = false
		var input_vector := get_input_vector()
		apply_horizontal_force(input_vector, delta)
		apply_friction(input_vector)
		jump_check()
		apply_gravity(delta)
		update_animations(input_vector)
		move()

func get_input_vector() -> Vector2:
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	return input_vector

func apply_horizontal_force(input_vector, delta) -> void:
	if input_vector.x != 0:
		motion.x += input_vector.x * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		
func apply_friction(input_vector) -> void:
	if input_vector.x == 0:
		motion.x = lerp(motion.x, 0, FRICTION)

func update_snap_vector():
	if is_on_floor():
		snap_vector = Vector2.DOWN

func jump_check():
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE
			just_jumped = true
	else:
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE / 2
	snap_vector = Vector2.ZERO

func apply_gravity(delta):
	motion.y += GRAVITY * delta
	motion.y = min(motion.y, JUMP_FORCE)

func update_animations(input_vector):
	if input_vector.x != 0:
		sprite.scale.x = sign(input_vector.x)
		animation_player.play("Run")
	else:
		animation_player.play("Idle")
	
	if not is_on_floor():
		animation_player.play("Jump")

func move() -> void:
	var was_on_floor := is_on_floor()
	motion = move_and_slide_with_snap(motion, snap_vector * 4, Vector2.UP, true, 4, deg2rad(MAX_SLOPE_ANGLE))
	if was_on_floor and not is_on_floor() and not just_jumped:
		motion.y = 0
		
