extends AnimatedSprite2D
var targets: Array
#var active_anim
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.play("rest")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
