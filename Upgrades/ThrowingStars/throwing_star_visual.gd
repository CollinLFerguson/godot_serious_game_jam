extends StaticBody2D

var stars_scene: PackedScene = preload("res://Upgrades/ThrowingStars/ThrowingStars.tscn")

func _ready() -> void:
	$StarTimer.start()

func _on_star_timer_timeout() -> void:
	var turtle = $".."
	var new_star = stars_scene.instantiate()
	
	turtle.add_collision_exception_with(new_star)
	add_collision_exception_with(new_star)
	get_tree().current_scene.add_child(new_star)

	new_star.global_position = self.global_position
