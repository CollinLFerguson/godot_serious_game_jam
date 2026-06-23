extends Node2D

var upgrade_options = {
	"sword": {"button": $SwordButton},
	"mace": {"button": $SwordButton},
}

var selected_upgrade = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MaceButton.pressed.connect(on_maceButton_pressed)
	$SwordButton.pressed.connect(on_swordButton_pressed)
	$StartBattleButton.pressed.connect(on_startBattleButton_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
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
		
func on_startBattleButton_pressed():
	# Play sound effect for hitting the button
	var sfx = $StartBattleButton/StartBattleSound
	sfx.play()
	$StartBattleButton.disabled = true
	await sfx.finished 
	
	SignalBus.upgrade_selected.emit(selected_upgrade)
	# Switch to next scene
	SignalBus.scene_switch.emit("res://Battle/battle.tscn")
