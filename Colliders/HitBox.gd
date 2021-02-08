## A hitbox is an area defining the layer by which it will cause damage
## whenever it encounters a hurtbox
class_name HitBox
extends Area2D

export(int) var damage # how much damage this will cause to the hurtbox
export(bool) var only_damage_on_landing

func _on_HitBox_area_entered(hurtbox):
	hurtbox.emit_signal("hit", damage, only_damage_on_landing)
