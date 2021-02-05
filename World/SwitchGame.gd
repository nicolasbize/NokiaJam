extends Node

onready var tie_parent := $Wall/Sprite/Ties
onready var bit_parent := $Wall/Sprite/Bits
onready var switch_parent := $Switches
onready var stone_parent := $Stones
onready var wall := $Wall

var bits := []
var ties := []
var switches := []
var stones := []
var comb := [0, 0, 0, 0]
var is_activated:bool = false

export (Array) var blocks = []

func _ready() -> void:
	bits = bit_parent.get_children()
	ties = tie_parent.get_children()
	switches = switch_parent.get_children()
	stones = stone_parent.get_children()

func update_sprites() -> void:
	comb = [0,0,0,0]
	for switch in switches:
		if switch.is_pressed:
			var activated:PoolStringArray = switch.text.split(",")
			for nb in activated:
				var link_index = int(nb) - 1
				comb[link_index] = (comb[link_index] + 1) % 2
	for i in range(bits.size()):
		bits[i].visible = comb[i] == 1
	ties[0].visible = comb[0] == 1
	ties[1].visible = comb[0] + comb[1] == 2
	ties[2].visible = comb[1] + comb[2] == 2
	ties[3].visible = comb[2] + comb[3] == 2
	ties[4].visible = comb[3] == 1
	var total := 0
	for c in comb:
		total += c
	if total == 4:
		wall.activate()		
		
func _on_Switch_pressed(switch: Sign) -> void:
	activate_mechanism()
	update_sprites()
	
func activate_mechanism() -> void:
	if not is_activated:
		is_activated = true
		for stone in stones:
			stone.activate()
