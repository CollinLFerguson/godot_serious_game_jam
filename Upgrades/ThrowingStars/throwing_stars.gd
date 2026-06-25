extends RigidBody2D

@export var damage = 5
@export var weight = 5

func _ready() -> void:
	linear_velocity = Vector2(800,800).rotated(randf_range(0, PI * 2))

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.rotation += .1


func _on_body_entered(body: Node) -> void:
	set_deferred("disabled", true)
	queue_free()
