extends Node

var EFFECTS: Dictionary = {}
var SOUNDTRACKS: Dictionary = {}

func _ready():
	_load_effects("res://SFX/Effects/")
	_load_soundtracks("res://SFX/Soundtrack/")
	
func _load_effects(path:String):
	var directory = DirAccess.open(path)
	if not directory:
		push_error("Effects directory could not be found")
	
	directory.list_dir_begin()
	var file_name = directory.get_next()
	
	while file_name != "":
		if not directory.current_is_dir() and file_name.ends_with(".tres"):
			var effect = load(path + file_name)
			if effect is AudioEffect:
				EFFECTS[file_name.get_basename()] = effect
		file_name = directory.get_next()

func _load_soundtracks(path:String):
	var directory = DirAccess.open(path)
	if not directory:
		push_error("Soundtracks directory could not be found")
	
	directory.list_dir_begin()
	var file_name = directory.get_next()
	
	while file_name != "":
		if not directory.current_is_dir() and file_name.ends_with(".tres"):
			var soundtrack = load(path + file_name)
			if soundtrack is AudioEffect:
				SOUNDTRACKS[file_name.get_basename()] = soundtrack
		file_name = directory.get_next()
	
func playBattleTheme():
	pass

func enableSoundtrack(soundtrack_identifier: String):
	pass

func disableSoundtrack():
	pass


func enableAudioEffect(effect_identifier: String):
	var bus_idx = AudioServer.get_bus_index("Effects")
	
	var effect = null
	if EFFECTS.has(effect_identifier):
		effect = EFFECTS[effect_identifier]
	if effect == null || !(effect is AudioEffect) :
		push_error("Invalid effect requested")
		return
	AudioServer.add_bus_effect(bus_idx, effect)
	
func disableAudioEffect(effect_identifier: String):
	var bus_idx = AudioServer.get_bus_index("Effects")
	
	var effect = null
	if EFFECTS.has(effect_identifier):
		effect = EFFECTS[effect_identifier]
	for i in AudioServer.get_bus_effect_count(bus_idx):
		var fx = AudioServer.get_bus_effect(bus_idx, i)
		if fx == effect:
			AudioServer.remove_bus_effect(bus_idx, i)	
