extends Node

var level_array = ["grungo",
					"first_battle.tscn", 
					"battle.tscn", 
					"battle_log.tscn", 
					"battle_tree.tscn", 
					"final_battle.tscn"]
var current_level = 0
var upgrade_list = []
var is_player_a_gigachad = false

func load_next_level() -> String:
	current_level += 1
	return level_array[current_level]

func reset_level():
	current_level = 0
	upgrade_list = []
	is_player_a_gigachad = false
