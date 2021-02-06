extends "res://Monsters/Enemy.gd"

enum FACING {DOWN = 180, UP = 0, LEFT = -90, RIGHT = 90}

const KrakenBullet = preload("res://Monsters/KrakenBullet.tscn")

export (FACING) var facing = FACING.DOWN

onready var sprite := $Sprite
onready var cooldown_timer := $CooldownTimer

var is_player_visible := false

func _process(delta):
	sprite.rotation_degrees = facing

func _on_VisionArea_area_entered(area):
	is_player_visible = true
	fire_bullet(area.global_position)

func fire_bullet(target:Vector2):
	
	var bullet := KrakenBullet.instance()
	bullet.global_position = sprite.global_position
	bullet.set_aim(target - global_position)
	get_tree().get_root().add_child(bullet)

func _on_VisionArea_area_exited(area):
	is_player_visible = false
