extends Node2D

var red_turtle_sprite = preload("res://Actors/Assets/player_turtle_red.png")
var orange_turtle_sprite = preload("res://Actors/Assets/player_turtle_orange.png")
var yellow_turtle_sprite = preload("res://Actors/Assets/player_turtle_yellow.png")
var green_turtle_sprite = preload("res://Actors/Assets/player_turtle.png")
var blue_turtle_sprite = preload("res://Actors/Assets/player_turtle_blue.png")
var purple_turtle_sprite = preload("res://Actors/Assets/player_turtle_purple.png")


func setColorPalletteButtons():
	var colors = [
		{"buttonObject": $RedColorButton, "code": "DF3100"},
		{"buttonObject": $OrangeColorButton, "code": "FB9C01"},
		{"buttonObject": $YellowColorButton, "code": "FFED00"},
		{"buttonObject": $GreenColorButton,"code": "29FF00"},
		{"buttonObject": $BlueColorButton, "code": "34EBFF"},
		{"buttonObject": $PurpleColorButton, "code": "760EF4"},
	]
	
	for c in colors:
		var normal_style = StyleBoxFlat.new()
		normal_style.bg_color = Color(c["code"])
		
		var hover_style = StyleBoxFlat.new()
		normal_style.bg_color = Color(c["code"])
		
		c["buttonObject"].add_theme_stylebox_override("normal", normal_style)
		c["buttonObject"].add_theme_stylebox_override("hover", hover_style)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setColorPalletteButtons()
	$StartBattleButton.pressed.connect(on_startBattleButton_pressed)
	$RedColorButton.pressed.connect(redButtonPressed)
	$OrangeColorButton.pressed.connect(orangeButtonPressed)
	$YellowColorButton.pressed.connect(yellowButtonPressed)
	$GreenColorButton.pressed.connect(greenButtonPressed)
	$BlueColorButton.pressed.connect(blueButtonPressed)
	$PurpleColorButton.pressed.connect(purpleButtonPressed)

func redButtonPressed():
	$Turtle.texture = red_turtle_sprite
	
func orangeButtonPressed():
	$Turtle.texture = orange_turtle_sprite
	
func yellowButtonPressed():
	$Turtle.texture = yellow_turtle_sprite

func greenButtonPressed():
	$Turtle.texture = green_turtle_sprite

func blueButtonPressed():
	$Turtle.texture = blue_turtle_sprite

func purpleButtonPressed():
	$Turtle.texture = purple_turtle_sprite

func on_startBattleButton_pressed():
	# Play sound effect for hitting the button
	var sfx = $StartBattleButton/StartBattleSound
	sfx.play()
	$StartBattleButton.disabled = true
	await sfx.finished 
	
	# Switch to next scene
	SignalBus.scene_switch.emit("res://UpgradeSelection/upgrade_select.tscn")
