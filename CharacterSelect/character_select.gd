extends Node2D



func setColorPalletteButtons():
	var colors = [
		{ "buttonObject": $RedColorButton, "code": "DF3100"},
		{ "buttonObject": $OrangeColorButton, "code": "FB9C01"},
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

func setUpCanvas():
	#line2d polyline with segments drawn, capture user mouse input
	#new object when created, line seg terminated when user lets go
	
	pass;
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setColorPalletteButtons()
	$StartBattleButton.pressed.connect(on_startBattleButton_pressed)

func on_startBattleButton_pressed():
	var sfx = $StartBattleButton/StartBattleSound
	sfx.play()
	await sfx.finished 
	SignalBus.scene_switch.emit("res://Battle/battle.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
