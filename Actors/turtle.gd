extends RigidBody2D

@export var min_velocity = 50
@export var base_velocity = Vector2(50,50)
@export var max_velocity = 200.0

@export var min_torque = 20.0
@export var base_torque = 50.0
@export var max_torque = 100.0

@export var sprite: SpriteFrames = load("res://Actors/Sprites/player.tres")

var items = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.sprite_frames = sprite

	apply_central_impulse(base_velocity)
	apply_torque_impulse(base_torque)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:	
	pass
	

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var vel := state.linear_velocity
	if vel.length() > max_velocity:
		state.linear_velocity = vel.normalized() * max_velocity
		
	if abs(state.angular_velocity) > max_torque:
		state.angular_velocity = sign(state.angular_velocity) * max_torque
