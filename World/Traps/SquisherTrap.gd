extends Node

onready var animation_player = $AnimationPlayer
onready var safe_area = $SafeArea
onready var switch = $Switch

var camera:Camera2D = null

func _ready() -> void:
	camera = get_node("/root/World/Camera2D")
	if camera == null:
		print("no camera")

func reset_trap() -> void:
	safe_area.monitoring = false
	animation_player.play("Reset")
	switch.reset()

func _on_Switch_status_change(pressed):
	animation_player.play("Activate")
	camera.screen_shake(0.1, 1.2)
	safe_area.set_deferred("monitoring", true)

func _on_SafeArea_body_entered(body):
	print("squisher solved!")
	GameState.solved_squisher = true
	safe_area.set_deferred("monitoring", false)
