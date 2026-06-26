extends Node2D

var selected_upgrade = ""
var button_names = ["optionButton1", "optionButton2", "optionButton3"]
var buttons = []

func _ready() -> void:
	buttons = [$optionButton1, $optionButton2, $optionButton3]
	populate_button_text()
	load_all_default_button_styles()
	
	$optionButton1.pressed.connect(optionButtonHandler.bind($optionButton1))
	$optionButton2.pressed.connect(optionButtonHandler.bind($optionButton2))
	$optionButton3.pressed.connect(optionButtonHandler.bind($optionButton3))
	
	$StartBattleButton.pressed.connect(on_startBattleButton_pressed)
	
func optionButtonHandler(button: Button):
	var text = button.text.split("\n")
	for b in buttons:
		if button.name != b.name:	
			var normal_style = StyleBoxFlat.new()
			var hover_style = StyleBoxFlat.new()
			normal_style.bg_color = Color("08356fff") 
			hover_style.bg_color = Color("185fbbff")
			b.add_theme_stylebox_override("normal", normal_style)
			b.add_theme_stylebox_override("hover", hover_style)
		else:
			var normal_style1 = StyleBoxFlat.new()
			var hover_style1 = StyleBoxFlat.new()
			normal_style1.bg_color = Color("e6ba4dff")
			hover_style1.bg_color = Color("7c5b23ff")
			button.add_theme_stylebox_override("normal", normal_style1)
			button.add_theme_stylebox_override("hover", hover_style1)
			var sfx = button.get_child(0)
			sfx.play()
			#await sfx.finished 
			
	selected_upgrade = text[0].strip_edges().to_lower()

func on_startBattleButton_pressed():
	# Play sound effect for hitting the button
	var sfx = $StartBattleButton/StartBattleSound
	sfx.play()
	$StartBattleButton.disabled = true
	ProgressionController.upgrade_list.append(selected_upgrade)
	SignalBus.upgrade_selected.emit(selected_upgrade)
	await sfx.finished
	
	
	# Switch to next scene
	var next_level = ProgressionController.load_next_level()
	SignalBus.scene_switch.emit("res://Battle/%s" %next_level)
	
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
	if ProgressionController.current_level < 4:
		var upgrades_dict = UpgradesController.UPGRADES
		var shuffled = upgrades_dict.keys().duplicate()
		shuffled.shuffle()
		var selected = shuffled.slice(0, 3) #upgrades array reduced to random 3 items
		
		var s = 0
		for b in button_names:
			var btn = get_node(b)
			btn.text = selected[s] + "\n" + upgrades_dict[selected[s]]["description"]
			s+=1
	else:
		var upgrades_dict = UpgradesController.UPGRADES
		var selected = ["mine", "stars"]
		var s = 0
		for b in button_names:
			if s < 2:
				var btn = get_node(b)
				btn.text = selected[s] + "\n" + upgrades_dict[selected[s]]["description"]
			else:
				var btn = get_node(b)
				btn.text = "No upgrade"
			s+=1
