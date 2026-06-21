extends Node

func _ready():
	#SignalBus.hit.connect(hitstop_short)
	pass
	

func hitstop_short():
	Engine.time_scale = 0.1
	await get_tree().create_timer(0.15, true, true, true).timeout
	Engine.time_scale = 1

func hitstop_long():
	Engine.time_scale = 0.1
	await get_tree().create_timer(0.30, true, true, true).timeout
	Engine.time_scale = 1
