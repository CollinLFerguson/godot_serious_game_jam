extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.battle_start.connect(handleSoundtrack)
	SignalBus.hit.connect(handleHitstop)
	SignalBus.hit.connect(handleParticles)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func handleSoundtrack():
	pass

func handleHitstop(source, target):
	if target.is_in_group('scenery'):
		return
	#define more conditions here.
	HitstopController.hitstop_short()

func handleParticles(source: Node2D, target) -> void:
	ParticleController.throwSparksParticle(source)
