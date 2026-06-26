extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if visible:
			get_tree().paused = false
			hide()
		else:
			get_tree().paused = true
			show()

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Soundtrack"), value)


func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
