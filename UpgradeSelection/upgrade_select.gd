extends Node2D

var selected_upgrade = ""
var button_names = ["optionButton1", "optionButton2", "optionButton3"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	populate_button_text()
	load_all_default_button_styles()
	SignalBus.load_soundtrack.emit("")
	#SignalBus.on_optionButton_pressed.connect(other_buttons_set_style)
	
	$optionButton1.pressed.connect(optionButtonHandler.bind($optionButton1))
	$optionButton2.pressed.connect(optionButtonHandler.bind($optionButton2))
	$optionButton3.pressed.connect(optionButtonHandler.bind($optionButton3))
	
	$StartBattleButton.pressed.connect(on_startBattleButton_pressed)
	
func optionButtonHandler(button: Button):
	var text = button.text.split("\n")
	
	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color("e6ba4dff")
	
	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color("7c5b23ff")
	
	button.add_theme_stylebox_override("normal", normal_style)
	button.add_theme_stylebox_override("hover", hover_style)
	SignalBus.on_optionButton_pressed.emit(button)
	selected_upgrade = text[0].strip_edges().to_lower()

func on_startBattleButton_pressed():
	# Play sound effect for hitting the button
	var sfx = $StartBattleButton/StartBattleSound
	sfx.play()
	$StartBattleButton.disabled = true
	$Turtle.upgrade_arr.append(selected_upgrade)
	SaveManager.save_game()
	await sfx.finished 
	
	SignalBus.upgrade_selected.emit(selected_upgrade)
	# Switch to next scene
	SignalBus.scene_switch.emit("res://Battle/battle.tscn")
	
func other_buttons_set_style(button: Button):
	var btns = button_names
	btns.erase(button.name)
	for b in btns:
		var other_btn = get_node(b)
		var normal_style = StyleBoxFlat.new()
		normal_style.bg_color = Color("08356fff")
		
		var hover_style = StyleBoxFlat.new()
		hover_style.bg_color = Color("185fbbff")
		
		other_btn.add_theme_stylebox_override("normal", normal_style)
		other_btn.add_theme_stylebox_override("hover", hover_style)
		
func load_all_default_button_styles():
	for b in button_names:
		var btn = get_node(b)
		var normal_style = StyleBoxFlat.new()
		normal_style.bg_color = Color("08356fff")
		
		var hover_style = StyleBoxFlat.new()
		hover_style.bg_color = Color("185fbbff")
		
		btn.add_theme_stylebox_override("normal", normal_style)
		btn.add_theme_stylebox_override("hover", hover_style)

func populate_button_text():
	var upgrades_dict = UpgradesController.UPGRADES
	var shuffled = upgrades_dict.keys().duplicate()
	shuffled.shuffle()
	var selected = shuffled.slice(0, 3) #upgrades array reduced to random 3 items
	
	var s = 0
	for b in button_names:
		var btn = get_node(b)
		btn.text = selected[s] + "\n" + upgrades_dict[selected[s]]["description"]
		s+=1

