extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$EndBattleButton.pressed.connect(endOfBattle)

func endOfBattle():
	Engine.time_scale = 1
	SignalBus.scene_switch.emit("res://UpgradeSelection/upgrade_select.tscn")
