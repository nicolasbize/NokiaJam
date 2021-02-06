extends Node2D

export(NodePath) var press = null

onready var animation_player = $AnimationPlayer

var camera:Camera2D = null

func _ready() -> void:
	camera = get_node("/root/World/Camera2D")
	if camera == null:
		print("no camera")
	if press != null:
		get_node(press).connect("press_change", self, "_on_Press_press_change")

func shake_screen() -> void:
	camera.screen_shake(0.1, 0.2)

func _on_Press_press_change(pressed):
	if pressed:
		animation_player.play("SlideUp")
	else:
		animation_player.play("SlideDown")
