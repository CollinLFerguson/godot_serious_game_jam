extends Node

func _ready():
	#SignalBus.hit.connect(hitstop_short)
	pass

func hitstop_short():
	hitstop(0.15)

func hitstop_long():
	hitstop(0.30)

func hitstop(time: float):
	Engine.time_scale = 0.1
	SoundController.enableAudioEffect("Hitstop")
	await get_tree().create_timer(time, true, true, true).timeout
	SoundController.disableAudioEffect("Hitstop")
	Engine.time_scale = 1
