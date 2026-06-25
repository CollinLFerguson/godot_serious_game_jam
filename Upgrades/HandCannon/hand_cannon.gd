extends StaticBody2D

@export var damage = 2
@export var weight = 2

var cannonballs_scene: PackedScene = preload("res://Upgrades/HandCannon/cannonball/Cannonball.tscn")
var explode_sound = preload("res://art/explosion/explosion.mp3")

func _ready() -> void:
	#call the spawn function for cannon balls, use 3 sec timer
	$CannonballTimer.start()


func _on_cannonball_timer_timeout() -> void:
	var turtle = $".."
	var new_ball = cannonballs_scene.instantiate()
	
	var turtle_velocity = turtle.linear_velocity
	var ball_velocity = turtle_velocity * 2
	#recoil will act on the turtle in 80% of ball velocity in opposite direction
	var cannon_recoil  = -0.8 * ball_velocity 
	
	turtle.apply_impulse(cannon_recoil)

	new_ball.apply_impulse(ball_velocity)
	
	turtle.add_collision_exception_with(new_ball)
	add_collision_exception_with(new_ball)
	get_tree().current_scene.add_child(new_ball)
	new_ball.global_position = self.get_node("EndPoint").global_position
	new_ball.z_index = self.z_index + 1
	$AudioStreamPlayer2D.stream = explode_sound
	$AudioStreamPlayer2D.play()
