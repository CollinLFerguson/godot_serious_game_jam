extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.hit.connect(handleHitstop)
	SignalBus.hit.connect(handleSparksParticles)
	SignalBus.hit.connect(handleDamage)
	SignalBus.mine_explosion.connect(handleMineExplosion)
	SignalBus.load_soundtrack.connect(handleSoundtrack)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func handleSoundtrack(track_name: String, loop: bool = false):
	SoundController.enableSoundtrack(track_name, loop)

func handleHitstop(source, target):
	if target.is_in_group('scenery'):
		return
	#define more conditions here.
	HitstopController.hitstop_short()

func handleSparksParticles(source: Node2D, target) -> void:
	ParticleController.throwSparksParticle(source)
	
func handleDamage(source, target):
	if target.get_class() == "RigidBody2D":
		pass
		
func handleMineExplosion(mine, target_list):
	ParticleController.throwExplosionParticle(mine)
	for tgt in target_list:
		if tgt.is_in_group("actor"):
			var pos_vec = 100*(tgt.position - mine.position)
			tgt.linear_velocity = pos_vec
			#if tgt.get_class() == "RigidBody2D":
				#tgt.apply_impulse(tgt.position, pos_vec)
			if tgt.has_method("apply_damage"):
				tgt.apply_damage(5)
	
