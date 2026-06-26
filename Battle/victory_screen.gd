extends Node
var default_screen_texture = preload("res://UI/Backgrounds/TurtleYouWinScreen.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureButton.pressed.connect(goToCredits)
	if !ProgressionController.is_player_a_gigachad:
		$TextureRect.texture = default_screen_texture
		SignalBus.load_soundtrack.emit("beta_ending")
	else:
		$TextureRect.texture = default_screen_texture
		SignalBus.load_soundtrack.emit("chad_ending")

func goToCredits():
	SignalBus.scene_switch.emit("res://Battle/credits_screen.tscn")
	
