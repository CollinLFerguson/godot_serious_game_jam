extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$StartGameButton.pressed.connect(on_startGameButton_pressed)

func on_startGameButton_pressed():
	var sfx = $StartGameButton/StartButtonSound
	sfx.play()
	$StartGameButton.disabled = true
	await sfx.finished 
	SignalBus.scene_switch.emit("res://CharacterSelect/character_select.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
