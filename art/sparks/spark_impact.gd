extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#await get_tree().create_timer(0.5).timeout
	#queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_finished():
	queue_free()
	#pass
