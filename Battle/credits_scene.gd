extends Node

func _ready() -> void:
	$TextureButton.pressed(goToCredits)

func goToCredits():
	SignalBus.scene_switch.emit("res://main.tscn")
