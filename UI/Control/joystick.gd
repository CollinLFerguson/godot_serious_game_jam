extends Control

@export var radius := 100.0
@onready var ball = $Ball

var dragging := false

func _ready() -> void:
	print($Base.visible)
	print($Ball.visible)
	
func _gui_input(event: InputEvent) -> void:
	var center = size / 2
	if(event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_LEFT):
			dragging = event.pressed
	elif (event is InputEventMouseMotion and dragging):
		var local_position = get_local_mouse_position()
		var offset = get_local_mouse_position() - center
		
		if (offset.length() > radius):
			offset = offset.normalized() * radius
		ball.position = center + offset - ball.size / 2

func get_input_vector() -> Vector2:
	var center = size / 2
	var ball_center = ball.position + ball.size / 2
	return -((ball_center - center) / radius)

func _on_start_button_pressed() -> void:
	var player_vector = get_input_vector()
	print("Launching turtle with vector:", player_vector)
	SignalBus.battle_start.emit(player_vector)
	self.queue_free()
