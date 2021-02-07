extends Node

onready var safe_area = $SafeArea
onready var platforms = $Platforms
onready var switch = $KrakenSwitch

func reset_trap() -> void:
	safe_area.monitoring = false
	for platform in platforms.get_children():
		platform.reset()
	switch.reset()
	for bullet in get_tree().get_nodes_in_group("Bullets"):
		bullet.queue_free()

func _on_SafeArea_body_entered(body):
	print("kraken solved!")
	GameState.solved_kraken = true
	safe_area.set_deferred("monitoring", false)
