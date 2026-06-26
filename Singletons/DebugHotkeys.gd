extends Node

func _unhandled_input(event: InputEvent) -> void:
	# Immediately stop if this is not a debug/editor run
	if not OS.is_debug_build():
		return
		
	if event.is_action_pressed("dev_kill_enemy"):
		var turts = get_tree().get_nodes_in_group("actor")
		if turts:
			for turt in turts:
				if !turt.is_player:
					turt.apply_damage(900)
