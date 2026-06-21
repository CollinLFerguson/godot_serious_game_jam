extends RigidBody2D

var sword_scene: PackedScene = preload("res://Upgrades/Assets/Sword/Sword.tscn")
var upgrade_list = ["sword", "sword", "sword"]	#can add swords to this to give player more swords
												#all the logic for this can be moved to the upgrades
												#tab when ready / someone feels like it
var actual_upgrades = []

@export var min_velocity = 600
@export var max_velocity = 2000.0
var base_velocity = Vector2(500,500).rotated(randf_range(0, PI * 2))

@export var health = 100

@export var min_angular_velocity = 20.0
@export var base_angular_velocity = 50.0
@export var max_angular_velocity = 100.0

@export var deceleration:float = .2

@export var sprite: SpriteFrames = load("res://Actors/Sprites/player.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in upgrade_list:
		if x == "sword":
			actual_upgrades.append(sword_scene.instantiate())
			
	var upgrade_spawn = $Center
	var num_swords = upgrade_list.count("sword")
	for i in range(num_swords):
		actual_upgrades[i].position = upgrade_spawn.position + Vector2(0,-100)\
		.rotated((i + 1) * 2 * PI / num_swords)
		actual_upgrades[i].rotation = ((i + 1) *2 * PI) / num_swords
		add_collision_exception_with(actual_upgrades[i])
		add_child(actual_upgrades[i])
		
	$AnimatedSprite2D.sprite_frames = sprite
	#SignalBus.upgrade_selected.emit(self, "Sword")
	#SignalBus.hit.connect()
	apply_central_impulse(base_velocity)
	apply_torque_impulse(base_angular_velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:	
	var velocity = linear_velocity
	apply_force(linear_velocity * -(1 - deceleration))
	

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var vel := state.linear_velocity
	var speed := vel.length()

	if speed > max_velocity:
		state.linear_velocity = vel.normalized() * max_velocity
	elif speed < min_velocity and speed > 0.0:
		state.linear_velocity = vel.normalized() * min_velocity
		
	$Speed.text = "%s" % health
	#$Speed.text = "%s" % int(state.linear_velocity.length())
	var angular: float = abs(state.angular_velocity)

	if angular > max_angular_velocity:
		state.angular_velocity = sign(state.angular_velocity) * max_angular_velocity
	elif angular < min_angular_velocity and angular > 0.0:
		state.angular_velocity = sign(state.angular_velocity) * min_angular_velocity
		
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("actor"):
		SignalBus.hit.emit(self, body)
		health -= int(body.linear_velocity.length() / 200)
		
	elif body.is_in_group("weapon"):
		SignalBus.hit.emit(self, body)
		health -= body.damage
		linear_velocity *= (1 + body.weight / 100)
	
	elif body.is_in_group("scenery"):
		if linear_velocity.length() > 1000:
			
			SignalBus.hit.emit(self, body)
			health -= int(linear_velocity.length() / 200)
		
		
	if health <= 0:
		queue_free()
		
		
func apply_damage():
	pass
