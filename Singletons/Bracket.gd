extends Node

var bracketArr = []

# number or rounds the player will go through
@onready var rounds = 3

# number of enemies in each round
@onready var enemies = 3

func _ready():
	SignalBus.player_died.connect(generateBracket)
	randomize()
	generateBracket()

func generateBracket():
	# 3 enemies per round
	for i in range(rounds):
		var row = []
		for j in range(enemies):
			row.append(getRandomUpgrade())
		bracketArr.append(row)
	

func getRandomUpgrade() -> String:
	var keys = Upgrades.upgrade_dict.keys()
	return keys.pick_random()
