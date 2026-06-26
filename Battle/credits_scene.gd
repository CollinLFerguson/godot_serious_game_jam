extends Node

func _ready() -> void:
	$TextureButton.pressed.connect(goToMain)

func goToMain():
	SignalBus.scene_switch.emit("res://main.tscn")
