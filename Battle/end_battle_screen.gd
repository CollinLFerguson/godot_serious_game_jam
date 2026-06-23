extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$EndBattleButton.pressed.connect(endOfBattle)

func endOfBattle():
	SignalBus.scene_switch.emit("res://UpgradeSelection/upgrade_selection.tscn")
