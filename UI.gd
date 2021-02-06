extends CanvasLayer

onready var sign_panel = $SignPanel
onready var sign_label = $SignPanel/SignLabel
onready var info_panel = $InfoPanel
onready var info_label = $InfoPanel/ColorRect/ColorRect2/InfoLabel

func _on_Player_start_reading(text:String) -> void:
	sign_label.text = text
	sign_panel.visible = true
	
func _on_Player_stop_reading() -> void:
	clear()

func show_info(text) -> void:
	info_label.text = text
	info_panel.visible = true

func clear() -> void:
	sign_panel.visible = false
	info_panel.visible = false
