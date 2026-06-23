extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_animation_finished() -> void:
	print("did explode")
	queue_free()
