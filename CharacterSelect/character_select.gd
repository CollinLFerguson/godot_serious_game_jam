extends Node2D

var canDraw: bool
var line: Line2D
var currentLine: Line2D

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
	canDraw = false
	line = $Line2D
	line.clear_points()
	setColorPalletteButtons()
	$PixelArtCanvas.mouse_entered.connect(mouseEnteredCanvas)
	$PixelArtCanvas.mouse_exited.connect(mouseExitedCanvas)
	$StartBattleButton.pressed.connect(on_startBattleButton_pressed)
	
func on_startBattleButton_pressed():
	# Save user drawing TODO this doesn't seem to work lmfao
	await RenderingServer.frame_post_draw
	var img: Image = $PixelArtCanvas/SubViewportContainer/SubViewport.get_texture().get_image()
	img.save_png("res://PlayerDrawing/playerDrawing.png")
	var userTexture := ImageTexture.create_from_image(img)
	
	# Play sound effect for hitting the button
	var sfx = $StartBattleButton/StartBattleSound
	sfx.play()
	$StartBattleButton.disabled = true
	await sfx.finished 
	
	# Switch to next scene
	SignalBus.scene_switch.emit("res://UpgradeSelection/upgrade_select.tscn")

func mouseEnteredCanvas():
	canDraw = true

func mouseExitedCanvas():
	canDraw = false
	currentLine = null

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				currentLine = line.duplicate()
				line.add_sibling(currentLine)
				currentLine.clear_points()
				if drawCheck(event.position, currentLine):
					currentLine.add_point(to_local(event.position))
			else:
				currentLine = null
	elif event is InputEventMouseMotion and currentLine != null:
		if drawCheck(event.position, currentLine):
			currentLine.add_point(to_local(event.position))

func drawCheck(mouse: Vector2, line: Line2D) -> bool:
	# First check if mouse is inside the drawing canvas area
	if canDraw:
		# Allow drawing if nothing has been drawn
		if line.points.size() == 0: 
			return true
		# Allow drawing if the mouse has moved
		if mouse != line.points[line.points.size() - 1]:
			return true
	return false
