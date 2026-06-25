extends Node2D

var upgrade_options = {
	"sword": {"button": $SwordButton},
	"mace": {"button": $MaceButton},
	"stars": {"button": $ThrowingStarsButton},
}

var selected_upgrade = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.load_soundtrack.emit("")
	$MaceButton.pressed.connect(on_maceButton_pressed)
	$SwordButton.pressed.connect(on_swordButton_pressed)
	$ThrowingStarsButton.pressed.connect(on_throwingStarsButton_pressed)
	$StartBattleButton.pressed.connect(on_startBattleButton_pressed)
	
func on_maceButton_pressed():
	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color("e6ba4dff")
	
	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color("7c5b23ff")
	
	$MaceButton.add_theme_stylebox_override("normal", normal_style)
	$MaceButton.add_theme_stylebox_override("hover", hover_style)
	selected_upgrade = "mace"
	
func on_swordButton_pressed():
	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color("e6ba4dff")
	
	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color("7c5b23ff")
	$SwordButton.add_theme_stylebox_override("normal", normal_style)
	$SwordButton.add_theme_stylebox_override("hover", hover_style)
	selected_upgrade = "sword"
	
func on_throwingStarsButton_pressed():
	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color("e6ba4dff")
	
	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color("7c5b23ff")
	$ThrowingStarsButton.add_theme_stylebox_override("normal", normal_style)
	$ThrowingStarsButton.add_theme_stylebox_override("hover", hover_style)
	selected_upgrade = "stars"
	
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
	SignalBus.scene_switch.emit("res://Battle/first_battle.tscn")
