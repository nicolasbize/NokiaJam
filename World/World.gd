extends Node2D

var last_checkpoint: Node2D = null
var pending_restart: bool = false
var pending_action:bool = false

onready var player := $Player
onready var ui := $UI
onready var camera := $Camera2D
onready var squisher := $Traps/Squisher
onready var switcher := $Traps/Switcher

func _on_Checkpoint_checkpoint(checkpoint:Node2D) -> void:
	last_checkpoint = checkpoint

func _on_Player_game_over() -> void:
	pending_restart = true
	ui.show_info("Press R to respawn")
	
func _on_Player_item_found(name):
	pending_action = true
	ui.show_info(name)
	
func _process(_delta) -> void:
	if pending_restart and Input.is_action_just_pressed("restart"):
		pending_restart = false
		player.transform = last_checkpoint.transform
		player.revive()
		if not GameState.solved_squisher:
			squisher.reset_trap()
		if not GameState.solved_switcher:
			switcher.reset_trap()
		ui.clear()
	elif pending_action and Input.is_action_just_pressed("interact"):
		pending_action = false
		player.store_item()
		ui.clear()
	
