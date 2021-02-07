## Let's take you home
class_name Spaceship
extends Sprite

onready var player_trigger = $PlayerTrigger
onready var hint_pointer = $HintPointer
onready var animation_player = $AnimationPlayer

signal game_completed

var camera:Camera2D = null

func _ready() -> void:
	camera = get_node("/root/World/Camera2D")
	if camera == null:
		print("no camera")
		
func _on_Player_power_core_found():
	hint_pointer.visible = true
	player_trigger.set_deferred("monitoring", true)

func complete_game():
	emit_signal("game_completed")

func _on_PlayerTrigger_use(player):
	if player.can_take_ship:
		player.take_off()
		camera.screen_shake(0.2, 2)
		animation_player.play("TakeOff")
		hint_pointer.visible = false	
