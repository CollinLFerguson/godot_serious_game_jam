extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.load_soundtrack.emit("main_menu")
	$RestartButton.pressed.connect(restart)

func restart():
	ProgressionController.reset_level()
	SignalBus.scene_switch.emit("res://main.tscn")
