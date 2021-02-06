extends Node2D

var camera:Camera2D = null
onready var animation_player = $AnimationPlayer

func _ready() -> void:
	camera = get_node("/root/World/Camera2D")
	if camera == null:
		print("no camera")

func shake_screen() -> void:
	camera.screen_shake(0.1, 0.2)

func _on_Press_press_change(pressed):
	if pressed:
		animation_player.play("SlideUp")
	else:
		animation_player.play("SlideDown")


func _on_HurtArea_area_entered(area):
	area.get_owner().explode()
