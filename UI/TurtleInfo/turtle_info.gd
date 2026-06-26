extends GridContainer

var turtle: Node = null
#var turtle_speed = 0.0
#var turtle_health = 0
var turtle_name = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.battle_over.connect(cleanup)
	$Name.text = str(turtle.turtle_name)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(turtle != null):
		global_position = turtle.global_position - size / 2
		$Health.text = str(max(turtle.health, 0))
		$Speed.text = str(turtle.linear_velocity.length())

func cleanup():
	self.queue_free()
 
