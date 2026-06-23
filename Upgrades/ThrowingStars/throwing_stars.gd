extends RigidBody2D

@export var damage = 5
@export var weight = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	linear_velocity = Vector2(500,500).rotated(randf_range(0, PI * 2))

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.rotation += .1


func _on_body_entered(body: Node) -> void:
	queue_free()
