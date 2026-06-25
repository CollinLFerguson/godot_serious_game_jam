extends Area2D
var targets: Array
@export var isarmed = false
var isspawned = false
var explode_sound = preload("res://art/explosion/explosion.mp3")
var mine_scene: PackedScene = preload("res://Upgrades/Mine/mine.tscn")
var parent_actor: Node
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	if isspawned:
		await get_tree().create_timer(1.0).timeout
		print("Spawned mine ready")
		#self.arm()
	else:
		$SpawnTimer.start()
	if isarmed:
		arm(null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node) -> void:
	#print("entered")
	if isarmed and body != parent_actor:
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

func arm(parent_actor):
	self.parent_actor = parent_actor
	await get_tree().create_timer(1.5).timeout
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
	#turtle.add_collision_exception_with(mine)
	mine.position = turtle.position
	get_tree().current_scene.add_child(mine)
	mine.arm(turtle)
	print("Spawned mine?")
