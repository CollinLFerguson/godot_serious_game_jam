extends RigidBody2D

const HIT_EFFECT: PackedScene = preload("res://art/sparks/spark_impact.tscn")

@export var min_velocity = 300
@export var base_velocity = Vector2(500,500)
@export var max_velocity = 1000.0

@export var min_angular_velocity = 20.0
@export var base_angular_velocity = 50.0
@export var max_angular_velocity = 100.0

@export var acceleration:float = 0.2

@export var sprite: SpriteFrames = load("res://Actors/Sprites/player.tres")

var items = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.sprite_frames = sprite
	#SignalBus.hit.connect()
	apply_central_impulse(base_velocity)
	apply_torque_impulse(base_angular_velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:	
	var velocity = linear_velocity
	apply_force(linear_velocity * (1 + acceleration))
	

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var vel := state.linear_velocity
	var speed := vel.length()

	if speed > max_velocity:
		state.linear_velocity = vel.normalized() * max_velocity
	elif speed < min_velocity and speed > 0.0:
		state.linear_velocity = vel.normalized() * min_velocity
	
	var angular: float = abs(state.angular_velocity)

	if angular > max_angular_velocity:
		state.angular_velocity = sign(state.angular_velocity) * max_angular_velocity
	elif angular < min_angular_velocity and angular > 0.0:
		state.angular_velocity = sign(state.angular_velocity) * min_angular_velocity
		
func spawn_effect(parent: Node2D) -> void:
	var effect = HIT_EFFECT.instantiate()
	get_tree().current_scene.add_child(effect)
	effect.global_position = parent.position  # sits at the parent's origin and rides along
	effect.global_rotation = parent.transform.get_rotation()
	effect.play()

func _on_body_entered(body: Node) -> void:
	SignalBus.hit.emit()
	spawn_effect(self)
