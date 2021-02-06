extends "res://Monsters/Enemy.gd"

enum DIRECTION { LEFT = -1, RIGHT = 1}

export(DIRECTION) var WALKING_DIRECTION

export (int) var ATTACK_SPEED = 60

var state = null
var is_attacking := false

onready var sprite = $Sprite
onready var floor_left = $FloorLeft
onready var floor_right = $FloorRight
onready var wall_left = $WallLeft
onready var wall_right = $WallRight
onready var vision_ray = $EyeSightArea/VisionRay

func _ready() -> void:
	state = WALKING_DIRECTION

func _physics_process(_delta) -> void:
	update_movement()
	sprite.scale.x = sign(motion.x)
	motion = move_and_slide_with_snap(motion, Vector2.DOWN*4, Vector2.UP, true, 4, deg2rad(46))
	update_animations()

func update_movement() -> void:
	var speed = MAX_SPEED
	if is_attacking:
		speed = ATTACK_SPEED
	match state:
		DIRECTION.RIGHT:
			motion.x = speed
			vision_ray.rotation_degrees = -90
			if not floor_right.is_colliding() or wall_right.is_colliding():
				state = DIRECTION.LEFT
				is_attacking = false
				sprite.frame = 0
				animation_player.stop()
				
		DIRECTION.LEFT:
			motion.x = -speed
			vision_ray.rotation_degrees = 90			
			if not floor_left.is_colliding() or wall_left.is_colliding():
				state = DIRECTION.RIGHT
				is_attacking = false
				sprite.frame = 0
				animation_player.stop()
		

func update_animations() -> void:
	if is_attacking:
		animation_player.play("Attack")
	else:
		animation_player.play("Walk")
	
func _on_EyeSightArea_body_entered(body) -> void:
	if not is_attacking:
		is_attacking = true
