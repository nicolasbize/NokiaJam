extends CanvasLayer

onready var sign_reading = $SignReading
onready var sign_label = $SignReading/SignLabel
onready var restart_label = $RestartLabel

func _on_Player_start_reading(text:String) -> void:
	sign_label.text = text
	sign_reading.visible = true
	
func _on_Player_stop_reading() -> void:
	clear()

func _on_Player_game_over() -> void:
	restart_label.visible = true

func clear() -> void:
	sign_reading.visible = false
	restart_label.visible = false
