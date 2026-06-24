extends RigidBody2D

@export var damage = 20
@export var weight = 15

func _ready() -> void:
	linear_velocity = Vector2(500,500).rotated(randf_range(0, PI * 2))

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.rotation += .1


func _on_body_entered(body: Node) -> void:
	queue_free()
