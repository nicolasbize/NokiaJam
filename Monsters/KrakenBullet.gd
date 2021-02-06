extends Projectile

const BULLET_SPEED = 10
var aim_target:Vector2 = Vector2.ZERO

func _process(delta) -> void:
	if not dying:
		position += BULLET_SPEED * delta * Vector2.DOWN

func set_aim(direction:Vector2) -> void:
	aim_target = direction

func _on_HurtArea_area_entered(area):
	print("OK")
	explode()
