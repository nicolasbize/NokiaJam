extends Node2D

const Bullet = preload("res://Projectiles/Bullet.tscn")

onready var sprite := $Sprite
onready var cooldown_timer := $CooldownTimer
onready var nozzle := $Nozzle
onready var vision_area := $VisionArea

export(float) var cooldown_time = 1
export(int) var bullet_speed = 20

var is_player_visible := false

func _on_VisionArea_area_entered(area):
	cooldown_timer.start(cooldown_time)

func fire():
	for area in vision_area.get_overlapping_areas():
		var bullet := Bullet.instance()
		get_parent().add_child(bullet)
		get_parent().move_child(bullet, 0)
		bullet.global_position = nozzle.global_position
		bullet.velocity = (area.global_position - global_position).normalized() * bullet_speed
		cooldown_timer.start(cooldown_time)

func _on_VisionArea_area_exited(area):
	cooldown_timer.stop()

func _on_CooldownTimer_timeout():
	fire()
