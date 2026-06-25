extends Node2D

var enemyCount = 2
const gameOverScene = preload("res://Battle/game_over_screen.tscn")
const endBattleScene = preload("res://Battle/end_battle_screen.tscn")
var stars_scene: PackedScene
var cannonballs_scene: PackedScene
var is_round_over = false
var zooming = false
var engine_time = 1.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.load_soundtrack.emit("battle_theme_srs")
	SignalBus.enemy_died.connect(enemyDied)
	SignalBus.player_died.connect(gameOver)

func _process(delta: float) -> void:
	zoom(delta)
	
func zoom(delta):
	var end: float = 2.0
	if zooming:
		$Camera2D.zoom.x = lerp($Camera2D.zoom.x, end, 0.6 * delta)
		$Camera2D.zoom.y = lerp($Camera2D.zoom.y, end, 0.6 * delta)
		engine_time = lerp(engine_time, .05, .6 * delta)
		Engine.time_scale = engine_time
		$Camera2D.position = $Turtle.position
		if $Camera2D.zoom.x > end * .8:
			zooming = false
	if is_round_over:
		$Camera2D.position = $Turtle.position

func enemyDied():
	enemyCount -= 1
	if enemyCount == 0:
		battleOver()

func gameOver():
	if !is_round_over:
		SignalBus.scene_switch.emit("res://Battle/game_over_screen.tscn")

func battleOver():
	SignalBus.battle_over.emit()
	is_round_over = true
	zooming = true
	var endBattleInstance = endBattleScene.instantiate()
	$CanvasLayer.add_child(endBattleInstance)
