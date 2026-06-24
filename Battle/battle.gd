extends Node2D

var enemyCount = 3
const gameOverScene = preload("res://Battle/game_over_screen.tscn")
const endBattleScene = preload("res://Battle/end_battle_screen.tscn")
var stars_scene: PackedScene
var cannonballs_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.battle_start.emit()
	SignalBus.load_soundtrack.emit("battle_theme_srs")
	SignalBus.enemy_died.connect(enemyDied)
	SignalBus.player_died.connect(gameOver)
	
	
	# Designating Turtle #1 as the player
	#$Turtle.is_player = true
	# $BattleTheme.play()
	
	

func enemyDied():
	enemyCount -= 1
	if enemyCount == 0:
		battleOver()

func gameOver():
	SignalBus.scene_switch.emit("res://Battle/game_over_screen.tscn")

func battleOver():
	var endBattleInstance = endBattleScene.instantiate()
	add_child(endBattleInstance)
