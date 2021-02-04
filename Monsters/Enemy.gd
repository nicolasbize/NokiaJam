extends KinematicBody2D

export (int) var MAX_SPEED = 15

onready var animation_player = $AnimationPlayer

var motion = Vector2.ZERO
