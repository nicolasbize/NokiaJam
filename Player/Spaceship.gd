## Let's take you home
class_name Spaceship
extends Sprite

onready var player_trigger = $PlayerTrigger
onready var hint_pointer = $HintPointer
onready var animation_player = $AnimationPlayer

signal game_completed

func _on_Player_power_core_found():
	hint_pointer.visible = true
	player_trigger.set_deferred("monitoring", true)

func complete_game():
	emit_signal("game_completed")

func _on_PlayerTrigger_use(player):
	player.take_off()
	animation_player.play("TakeOff")
	hint_pointer.visible = false	
