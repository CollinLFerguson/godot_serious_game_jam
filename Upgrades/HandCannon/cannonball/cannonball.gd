extends RigidBody2D

@export var damage = 20
@export var weight = 60
@export var collisionsBeforeDecay = 3
#@export var secondsBeforeDecay = 5.0
var base_velocity

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	pass

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.rotation += .1


func _on_body_entered(body: Node) -> void:
	if (body.is_in_group("actor") || body.is_in_group("player")):
		set_deferred("disabled", true)
		queue_free()
	elif (body.is_in_group("projectile") || body.is_in_group("scenery") || body.is_in_group("weapon")):
		collisionsBeforeDecay = collisionsBeforeDecay - 1 #mark as a collision
		if collisionsBeforeDecay == 0:
			set_deferred("disabled", true)
			queue_free()
