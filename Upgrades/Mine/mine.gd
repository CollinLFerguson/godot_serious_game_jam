extends Area2D
var targets: Array
var isarmed = false
var isspawned = false
var explode_sound = preload("res://art/explosion/explosion.mp3")
var mine_scene: PackedScene = preload("res://Upgrades/Mine/mine.tscn")
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	if isspawned:
		await get_tree().create_timer(1.0).timeout
		print("Spawned mine ready")
		self.arm()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	#print("entered")
	if isarmed:
		#print("blow up")
		SignalBus.mine_explosion.emit(self, targets)
		$AudioStreamPlayer2D.stream = explode_sound
		$AudioStreamPlayer2D.play()
		self.disable()
	
func add_target(object: Node):
	targets.append(object)
	#print(targets)

func remove_target(object: Node):
	var tgt_loc = targets.find(object)
	targets.pop_at(tgt_loc)
	
func disable():
	self.set_deferred("monitoring", false)
	self.set_deferred("monitorable", false)
	$Mine_AOE.set_deferred("monitoring", false)
	$Mine_AOE.set_deferred("monitorable", false)
	$Mine_animation.animation = "explode"
	isarmed = false

func arm():
	self.isarmed = true
	$Mine_animation.animation = "armed"
	self.set_deferred("monitoring", true)
	self.set_deferred("monitorable", true)
	$Mine_AOE.set_deferred("monitoring", true)
	$Mine_AOE.set_deferred("monitorable", true)

func _on_spawn_timer_timeout() -> void:
	var turtle = $".."
	var mine = mine_scene.instantiate()
	mine.isspawned = true
	mine.arm()
	turtle.add_collision_exception_with(mine)
	mine.position = turtle.position
	turtle.add_child(mine)
	print("Spawned mine?")
