extends RigidBody2D

@export var damage = 20
@export var weight = 60

var base_velocity

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.rotation += .1


func _on_body_entered(body: Node) -> void:
	set_deferred("disabled", true)
	queue_free()
