## Guess what this class does
class_name MainMenu
extends Control

enum {NEW_GAME, HELP, QUIT}

onready var menu_container = $ColorRect/MenuContainer
onready var screen_dissolver = $ScreenDissolver
onready var help_container = $HelpContainer

var selected_item := 0

func _process(delta) -> void:
	if help_container.visible:
		if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_cancel"):
			help_container.visible = false
	else:
		var nb_items = menu_container.get_child_count()
		var new_selection = null
		if Input.is_action_just_pressed("ui_down") and selected_item < nb_items - 1:
			new_selection = selected_item + 1
		if Input.is_action_just_pressed("ui_up") and selected_item > 0:
			new_selection = selected_item - 1
		if new_selection != null:
			menu_container.get_children()[selected_item].deselect()
			menu_container.get_children()[new_selection].select()
			selected_item = new_selection
		
		if Input.is_action_just_pressed("ui_accept"):
			match selected_item:
				NEW_GAME:
					screen_dissolver.fade()
					yield(get_tree().create_timer(2), "timeout")
					get_tree().change_scene("res://World/World.tscn")
				HELP:
					help_container.visible = true
				QUIT:
					get_tree().quit()
