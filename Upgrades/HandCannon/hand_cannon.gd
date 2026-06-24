extends StaticBody2D

@export var damage = 2
@export var weight = 2

var cannonballs_scene: PackedScene = preload("res://Upgrades/HandCannon/cannonball/Cannonball.tscn")

func _ready() -> void:
	#call the spawn function for cannon balls, use 3 sec timer
	$CannonballTimer.start()


func _on_cannonball_timer_timeout() -> void:
	var turtle = $".."
	var new_ball = cannonballs_scene.instantiate()
	new_ball.position = position
	
	var turtle_velocity = turtle.linear_velocity
	
	new_ball.apply_impulse(turtle_velocity * 2)
	
	turtle.add_collision_exception_with(new_ball)
	add_collision_exception_with(new_ball)
	turtle.add_child(new_ball)
