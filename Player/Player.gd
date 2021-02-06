extends KinematicBody2D

export (int) var ACCELERATION = 512
export (int) var MAX_SPEED = 52
export (float) var FRICTION = 0.35
export (int) var GRAVITY = 220
export (int) var JUMP_FORCE = 80
export (int) var MAX_SLOPE_ANGLE = 46
export (bool) var can_wall_jump = false

enum {
	MOVE, WALL_SLIDE
}

var state := MOVE
var motion := Vector2.ZERO
var snap_vector := Vector2.ZERO
var just_jumped := false
var is_reading := false
var is_dead := false
var is_ducking := false

signal stop_reading
signal start_reading
signal game_over
signal dying

onready var sprite = $Sprite
onready var animation_player = $AnimationPlayer
onready var interaction_area = $InteractionArea

func _physics_process(delta) -> void:
	just_jumped = false
	if not is_dead:
		visible = true
		if not is_reading:
			var input_vector := get_input_vector()
			match state:
				MOVE:
					apply_horizontal_force(input_vector, delta)
					apply_friction(input_vector)
					jump_check()
					duck_check()
					apply_gravity(delta)
					update_animations(input_vector)
					move()
					wall_slide_check()
				WALL_SLIDE:
					animation_player.play("WallSlide")
					var wall_axis = get_wall_axis()
					if wall_axis != 0:
						sprite.scale.x = wall_axis
					print("wall slide jump check")
					wall_slide_jump_check(wall_axis, input_vector)
					#wall_slide_drop_check(delta)
					apply_gravity(delta)
					move()
					wall_detach_check(wall_axis)
					
		interaction_check()
	else:
		animation_player.play("Die")

func get_input_vector() -> Vector2:
	var input_vector := Vector2.ZERO
	if not is_ducking:
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	return input_vector

func apply_horizontal_force(input_vector, delta) -> void:
	if input_vector.x != 0:
		motion.x += input_vector.x * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		
func apply_friction(input_vector) -> void:
	if input_vector.x == 0:
		motion.x = lerp(motion.x, 0, FRICTION)

func update_snap_vector() -> void:
	if is_on_floor():
		snap_vector = Vector2.DOWN

func duck_check() -> void:
	if not is_ducking and Input.is_action_pressed("ui_down"):
		is_ducking = true
	elif is_ducking and Input.is_action_just_released("ui_down"):
		is_ducking = false

func jump_check() -> void:
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMP_FORCE
			just_jumped = true
	else:
		if Input.is_action_just_released("jump") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE / 2
	snap_vector = Vector2.ZERO

func interaction_check() -> void:
	var interacted : Array = interaction_area.get_overlapping_areas()
	if Input.is_action_just_pressed("interact") and interacted.size() > 0:
		var item : Area2D = interacted[0]
		if item.is_in_group("Switchable"):
			item.get_parent().switch()
		elif item.is_in_group("Readable"):
			if is_reading:
				emit_signal("stop_reading")
				is_reading = false
			else:
				emit_signal("start_reading", item.get_parent().text)
				is_reading = true
		

func apply_gravity(delta) -> void:
	motion.y += GRAVITY * delta
	motion.y = min(motion.y, JUMP_FORCE)

func update_animations(input_vector) -> void:
	if input_vector.x != 0:
		sprite.scale.x = sign(input_vector.x)
		animation_player.play("Run")
	else:
		if is_ducking:
			animation_player.play("Duck")
		else:
			animation_player.play("Idle")
	
	if not is_on_floor():
		animation_player.play("Jump")

func move() -> void:
	var was_on_floor := is_on_floor()
	motion = move_and_slide_with_snap(motion, snap_vector * 4, Vector2.UP, false, 4, deg2rad(MAX_SLOPE_ANGLE))
	if was_on_floor and not is_on_floor() and not just_jumped:
		motion.y = 0
		
func hide() -> void:
	visible = false
	emit_signal("game_over")

func revive() -> void:
	animation_player.play("Idle")
	is_dead = false
	visible = true
	motion = Vector2.ZERO

func get_wall_axis() -> int:
	var is_right_wall = test_move(transform, Vector2.RIGHT)
	var is_left_wall = test_move(transform, Vector2.LEFT)
	return int(is_left_wall) - int(is_right_wall)

func wall_slide_jump_check(wall_axis, input_vector):
	if Input.is_action_just_pressed("jump"):
		if sign(wall_axis) == sign(input_vector.x):
			motion.x = 2 * wall_axis * MAX_SPEED
			motion.y = -JUMP_FORCE
		else: # wall jumping against the same wall
			motion.x = wall_axis * MAX_SPEED
			motion.y = -JUMP_FORCE / 2
		state = MOVE

func wall_slide_drop_check(delta):
		if Input.is_action_just_pressed("ui_right"):
			motion.x = ACCELERATION * delta
			state = MOVE
		
		if Input.is_action_just_pressed("ui_left"):
			motion.x = -ACCELERATION * delta
			state = MOVE

func wall_slide_check() -> void:
	if not is_on_floor() and is_on_wall() and can_wall_jump:
		state = WALL_SLIDE

func wall_detach_check(wall_axis):
	if wall_axis == 0 or is_on_floor():
		state = MOVE

func _on_HurtArea_area_entered(_area) -> void:
	is_dead = true
	emit_signal("dying")

