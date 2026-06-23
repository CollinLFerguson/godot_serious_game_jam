extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RestartButton.pressed.connect(restart)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func restart():
	SignalBus.scene_switch.emit("res://main.tscn")
