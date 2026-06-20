extends RigidBody2D

@export var base_velocity = Vector2(1,1)
@export var base_torque = 60
@export var max_velocity = 200

var items = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_force(base_velocity)
	apply_torque(base_torque)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var velocity := state.get_linear_velocity()
	var torque := state.get_constant_torque()
	var step := state.get_step()
	
	apply_torque(torque)
	apply_force(velocity.limit_length(max_velocity))
	
	for i in state.get_contact_count():
		var normal = state.get_contact_local_normal(i)
		linear_velocity = linear_velocity.bounce(normal)
	
