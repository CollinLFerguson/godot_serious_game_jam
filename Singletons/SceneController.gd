extends Node

func _ready():
	SignalBus.scene_switch.connect(switchScene)
	
func switchScene(scenePath: String):
	get_tree().change_scene_to_file.call_deferred(scenePath)
