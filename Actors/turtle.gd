extends RigidBody2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_force(Vector2(1,1))
	apply_torque(60)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var velocity := state.get_linear_velocity()
	var torque := state.get_constant_torque()
	var step := state.get_step()
	
	apply_torque(torque)
	apply_force(velocity)
	
