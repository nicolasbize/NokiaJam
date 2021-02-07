extends Node2D

var last_checkpoint:Node2D = null
var pending_restart:bool = false
var pending_action:bool = false
var deaths := 0
var init_time := 0

onready var player := $Player
onready var ui := $UI
onready var camera := $Camera2D
onready var squisher := $Traps/Squisher
onready var switcher := $Traps/Switcher
onready var kraken := $Traps/KrakenTown
onready var boulder := $Traps/Boulder
onready var music_main_theme := $Audio/MusicMainTheme
onready var music_equipment := $Audio/MusicEquipment
onready var music_ending := $Audio/MusicEnding

func _ready():
	init_time = OS.get_ticks_msec()

func _on_Checkpoint_checkpoint(checkpoint:Node2D) -> void:
	last_checkpoint = checkpoint

func _on_Player_game_over() -> void:
	pending_restart = true
	deaths += 1
	ui.show_info("Press R to respawn")
	
func _on_Player_item_found():
	music_main_theme.stop()
	yield(get_tree().create_timer(0.2), "timeout")
	music_equipment.play()
	
func _process(_delta) -> void:
	if pending_restart and Input.is_action_just_pressed("restart"):
		pending_restart = false
		player.transform = last_checkpoint.transform
		player.revive()
		if not GameState.solved_squisher:
			squisher.reset_trap()
		if not GameState.solved_switcher:
			switcher.reset_trap()
		if not GameState.solved_kraken:
			kraken.reset_trap()
		if not GameState.solved_boulder:
			boulder.reset_trap()
		ui.clear()
	elif pending_action and Input.is_action_just_pressed("interact"):
		pending_action = false
		player.store_item()
		ui.clear()
		music_equipment.stop()
		yield(get_tree().create_timer(0.5), "timeout")
		music_main_theme.play()

func _on_Spaceship_game_completed():
	ui.show_score(deaths, int((OS.get_ticks_msec() - init_time)/1000))
	music_main_theme.stop()
	yield(get_tree().create_timer(0.5), "timeout")
	music_ending.play()

func _on_Player_item_equipped(name):
	pending_action = true
	ui.show_info(name)
