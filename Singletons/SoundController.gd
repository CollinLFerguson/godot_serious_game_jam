extends Node

var EFFECTS: Dictionary = {}
var tracks = [preload("res://SFX/Soundtrack/main_menu.mp3"), preload("res://SFX/Soundtrack/battle_theme_srs.mp3")]
var SOUNDTRACKS: Dictionary = {"main_menu":tracks[0], "battle_theme_srs": tracks[1]}

var MUSIC_STREAM: AudioStreamPlayer
var current_soundtrack:String = ""

func _ready():
	_read_effects_directory("res://SFX/TrackEffects/")
	#_load_soundtracks("res://SFX/Soundtrack/")
	_initiate_music_player()
	
func _initiate_music_player():
	MUSIC_STREAM = AudioStreamPlayer.new()
	MUSIC_STREAM.bus = "Soundtrack"
	add_child(MUSIC_STREAM)
	
func _load_effects(path:String, dir_name):
	var directory = DirAccess.open(path)
	if not directory:
		push_error("Effects directory could not be found")
		return
	
	directory.list_dir_begin()
	var file_name = directory.get_next()
	
	while file_name != "":
		if not directory.current_is_dir() and file_name.ends_with(".tres"):
			var effect = load(path + file_name)
			if effect is AudioEffect:
				EFFECTS[dir_name].append(effect)
		file_name = directory.get_next()

func _read_effects_directory(path):
	var directory = DirAccess.open(path)
	if not directory:
		push_error("Effects directory could not be found")
		return
	
	directory.list_dir_begin()
	var file_name = directory.get_next()
	
	while file_name != "":
		if directory.current_is_dir() and file_name != "." or file_name != "..":
			EFFECTS[file_name] = []
			_load_effects(path + file_name + "/", file_name)
		file_name = directory.get_next()
	
func _load_soundtracks(path:String):
	var directory = DirAccess.open(path)
	if not directory:
		push_error("Soundtracks directory could not be found")
	
	directory.list_dir_begin()
	var file_name = directory.get_next()
	
	while file_name != "":
		if not directory.current_is_dir() and file_name.ends_with(".mp3"):
			var soundtrack = load(path + file_name)
			if soundtrack is AudioStreamMP3:
				SOUNDTRACKS[file_name.get_basename()] = soundtrack
		file_name = directory.get_next()
	
func playBattleTheme():
	pass

func enableSoundtrack(soundtrack_identifier: String, loop: bool = true):
	if(soundtrack_identifier == current_soundtrack):
		return
	var _bus_idx = AudioServer.get_bus_index("Soundtrack")
	if(!SOUNDTRACKS.has(soundtrack_identifier)):
		MUSIC_STREAM.stop()
		return
	var track = SOUNDTRACKS[soundtrack_identifier]
	if(loop == true):
		track.loop()
	MUSIC_STREAM.stream = track
	MUSIC_STREAM.play()
	current_soundtrack = soundtrack_identifier
	
func disableSoundtrack():
	MUSIC_STREAM.stop()


func enableAudioEffect(effect_identifier: String):
	var bus_idx = AudioServer.get_bus_index("Effects")
	
	var effects = null
	if EFFECTS.has(effect_identifier):
		effects = EFFECTS[effect_identifier]
	if effects == null || !(effects is Array) :
		push_error("Invalid effect requested")
		return
	for effect in effects:
		if(effect is AudioEffect):
			AudioServer.add_bus_effect(bus_idx, effect)
	
func disableAudioEffect(effect_identifier: String):
	var bus_idx = AudioServer.get_bus_index("Effects")
	
	var effects = null
	if EFFECTS.has(effect_identifier):
		effects = EFFECTS[effect_identifier]
	for i in range(AudioServer.get_bus_effect_count(bus_idx) - 1, -1, -1):
		var fx = AudioServer.get_bus_effect(bus_idx, i)
		if fx in effects:
			AudioServer.remove_bus_effect(bus_idx, i)
