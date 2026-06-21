extends Node

func _ready():
	SignalBus.battle_start.connect(playBattleTheme)

func playBattleTheme():
	pass
