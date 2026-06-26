extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureButton.pressed.connect(goToCredits)

func goToCredits():
	SignalBus.scene_switch.emit("res://Battle/credits_screen.tscn")
	
