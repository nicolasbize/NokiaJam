extends Node

onready var animation_player = $AnimationPlayer
onready var path_follow_2d = $Path2D/PathFollow2D
onready var boulder = $Boulder2

func reset_trap() -> void:
	animation_player.stop()
	path_follow_2d.offset = 0
	boulder.reset()
	
func _on_PlayerTrigger_area_entered(area):
	animation_player.play("BoulderFalling")
	boulder.visible = true

func _on_SafeArea_body_entered(body):
	print("boulder solved!")
	GameState.solved_boulder = true
