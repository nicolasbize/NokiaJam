extends Node

onready var animation_player = $AnimationPlayer
onready var path_follow_2d = $Path2D/PathFollow2D
onready var boulder = $Boulder2

var camera:Camera2D = null

func _ready() -> void:
	camera = get_node("/root/World/Camera2D")
	if camera == null:
		print("no camera")

func reset_trap() -> void:
	animation_player.stop()
	camera.stop_screen_shake()
	path_follow_2d.offset = 0
	boulder.reset()
	
func _on_PlayerTrigger_area_entered(area):
	animation_player.play("BoulderFalling")
	camera.screen_shake(0.1, 7)
	boulder.visible = true

func _on_SafeArea_body_entered(body):
	print("boulder solved!")
	GameState.solved_boulder = true
