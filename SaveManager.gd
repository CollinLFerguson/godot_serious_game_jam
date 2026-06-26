extends Node

var player_sprite_choice: String

#Keeping this here for historic evidence, but its completely worthless, moved over to Jonah's progression controller
func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		if node.is_player == false:
			continue
		
		if node.scene_file_path.is_empty():
			print("persistent node %s is not an instanced scene, skipped" % node.name)
			continue
		
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue
		
		
		var node_data = node.call("save")
		
		var json_string = JSON.stringify(node_data)
		
		save_file.store_line(json_string)
		
func load_game(player):
	if not FileAccess.file_exists("user://savegame.save"):
		return
		
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_liprint_orphan_nodes())
			continue
			
		var node_data = json.data
		player.upgrade_arr.assign(node_data["upgrades"])
		
		
func clear_save():
	#var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	DirAccess.remove_absolute("user://savegame.save")
		
		
