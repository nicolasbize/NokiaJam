extends Sprite

onready var animation_player = $AnimationPlayer

func fade():
	animation_player.play("FadeToBlack")
