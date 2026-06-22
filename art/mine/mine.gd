extends Area2D
var targets: Array
var isarmed = true
var explode_sound = preload("res://art/explosion/loud-explosion.mp3")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Mine_animation.animation == "armed":
		isarmed = true


func _on_body_entered(body: Node) -> void:
	#print("entered")
	if isarmed:
		#print("blow up")
		SignalBus.mine_explosion.emit(self, targets)
		$"../AudioStreamPlayer2D".stream = explode_sound
		$"../AudioStreamPlayer2D".play()
	
func add_target(object: Node):
	targets.append(object)
	#print(targets)

func remove_target(object: Node):
	var tgt_loc = targets.find(object)
	targets.pop_at(tgt_loc)
