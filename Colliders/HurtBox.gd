## A hurtbox is an area defining the layer by which the attached object
## can be hurt. Whenever another area enters this, it will deal damage
class_name HurtBox
extends Area2D

signal hit(damage, only_damage_on_landing) # emited when this hurtbox was hit
