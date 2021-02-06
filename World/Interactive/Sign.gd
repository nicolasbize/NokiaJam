## Because the previous tenants of this planet were nice enough to leave
## signs written in English
class_name Sign
extends Sprite

onready var hint_pointer = $HintPointer

export (String) var text := ""

func _on_PlayerTrigger_area_entered(area):
	hint_pointer.visible = true

func _on_PlayerTrigger_area_exited(area):
	hint_pointer.visible = false

func _on_PlayerTrigger_use(player):
	player.use_sign(text)
