extends RigidBody2D

@export var base_velocity = Vector2(1,1)

@export var max_velocity = 200
@export var base_torque = 300

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
	var velocity = linear_velocity
	#var rotation_speed = angular_velocity
	#apply_torque(rotation_speed)


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var velocity := state.get_linear_velocity()
	#var torque := state.get_constant_torque()
	#var step := state.get_step()
	
	apply_force(velocity.limit_length(max_velocity))

	# Handle bounce correctly via state
	for i in range(state.get_contact_count()):
		var normal = state.get_contact_local_normal(i)
		var v = state.get_linear_velocity()
		state.set_linear_velocity(v.bounce(normal))
