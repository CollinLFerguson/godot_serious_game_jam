extends Node2D

var enemyCount = 3
const gameOverScene = preload("res://Battle/game_over_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.battle_start.emit()
	SignalBus.enemy_died.connect(enemyDied)
	SignalBus.player_died.connect(gameOver)
	
	SaveManager.save_game()
	SaveManager.load_game()
	# $BattleTheme.play()
	
	# Designating Turtle #1 as the player
	$Turtle.is_player = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enemyDied():
	enemyCount -= 1
	if enemyCount == 0:
		battleOver()

func gameOver():
	var gameOverInstance = gameOverScene.instantiate()
	add_child(gameOverInstance)

func battleOver():
	print("You win!")
