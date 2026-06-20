extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_force(Vector2(1,1))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var velocity := state.get_linear_velocity()
	var step := state.get_step()
	
	apply_torque(60)
	apply_force(velocity)
	
