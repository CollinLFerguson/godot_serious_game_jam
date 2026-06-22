extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.battle_start.emit()
	SaveManager.save_game()
	SaveManager.load_game()
	$BattleTheme.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
