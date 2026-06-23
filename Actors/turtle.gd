extends RigidBody2D

var stars_scene: PackedScene = preload("res://Upgrades/ThrowingStars/ThrowingStars.tscn")

@export var min_velocity = 600
@export var max_velocity = 2000.0

@export var health = 100

@export var min_angular_velocity = 20.0
@export var base_angular_velocity = 50.0
@export var max_angular_velocity = 100.0

@export var rotation_factor: float = 2.0
@export var torque_strength: float = 50.0

@export var scenery_damage_threshhold:float = 1000

@export var deceleration:float = 0.2
@export var sprite: SpriteFrames = load("res://Actors/Sprites/player.tres")
var sword_sound = preload("res://SFX/Effects/sword_sound.mp3")
var pain_sound = preload("res://SFX/Effects/turtle_hurt2.mp3")
var terrain_sound = preload("res://SFX/Effects/crunch.mp3")

var is_player = false
var upgrade_dict = {"stars":1}
var base_velocity = Vector2(500,500).rotated(randf_range(0, PI * 2))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.load_upgrades.emit(self, ["mace"])
	$AnimatedSprite2D.sprite_frames = sprite
	apply_central_impulse(base_velocity)
	apply_torque_impulse(base_angular_velocity)
	if upgrade_dict["stars"] > 0:
		$StarTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Labels/Health.text = "%s" % health
	

func _physics_process(_delta: float) -> void:	
	$Labels/Speed.text = "%s" % linear_velocity.length()
	var velocity = linear_velocity.length()
	apply_force(linear_velocity * -(1 - deceleration))
	
	var target_av = velocity * rotation_factor
	var av_error = target_av - angular_velocity
	apply_torque(av_error * torque_strength)
	

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var vel := state.linear_velocity
	var speed := vel.length()

	if speed > max_velocity:
		state.linear_velocity = vel.normalized() * max_velocity
	elif speed < min_velocity and speed > 0.0:
		state.linear_velocity = vel.normalized() * min_velocity
		
	
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
		$AudioStreamPlayer2D.stream = pain_sound
		$AudioStreamPlayer2D.play()
	elif body.is_in_group("weapon"):
		SignalBus.hit.emit(self, body)
		health -= body.damage

		apply_impulse(linear_velocity * (1 + body.weight / 100))
		$AudioStreamPlayer2D.stream = sword_sound
		$AudioStreamPlayer2D.play()
	
	elif body.is_in_group("scenery"):
		if linear_velocity.length() > scenery_damage_threshhold:
			
			SignalBus.hit.emit(self, body)
			health -= int(linear_velocity.length() / 200)
			$AudioStreamPlayer2D.stream = terrain_sound
			$AudioStreamPlayer2D.play()
	if health <= 0:
		$AudioStreamPlayer2D.stream = pain_sound
		$AudioStreamPlayer2D.play()
		if is_player:
			SignalBus.player_died.emit()
		if not is_player:
			SignalBus.enemy_died.emit()
		queue_free()
	
func apply_damage():
	pass

func save_upgrades():
	if is_player:
		return [UpgradesController.UPGRADES]
	else:
		return upgrade_dict

func save():
	var upgrades = save_upgrades()
	var save_dict = {
		"upgrades" : upgrades,
		"is_player" : is_player
	}
	
	return save_dict

func reportStats(): 
	pass


func _on_star_timer_timeout() -> void:
	#get_parent().stars_scene = stars_scene
	var new_star = stars_scene.instantiate()
	new_star.position = position
	add_collision_exception_with(new_star)
	get_parent().add_child(new_star)
