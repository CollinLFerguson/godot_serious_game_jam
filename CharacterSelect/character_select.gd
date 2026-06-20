extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StartBattleButton.pressed.connect(on_startBattleButton_pressed)

func on_startBattleButton_pressed():
	var sfx = $StartBattleButton/StartBattleSound
	sfx.play()
	await sfx.finished 
	SignalBus.scene_switch.emit("res://Battle/battle.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
