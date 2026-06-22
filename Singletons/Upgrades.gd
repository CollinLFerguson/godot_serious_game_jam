extends Node

var sword_scene: PackedScene = preload("res://Upgrades/Sword/Sword.tscn")
var mace_scene: PackedScene = preload("res://Upgrades/Mace/Mace.tscn")

@onready var mace = get_node("/root/Upgrades/Mace")

var upgrade_dict = {"sword":3, "mace": 2}

var upgrade_list = ["mace", "mace"]	#can add swords to this to give player more swords
												#all the logic for this can be moved to the upgrades
												#tab when ready / someone feels like it
var actual_upgrades = []


func _ready() -> void:
	SignalBus.upgrade_selected.connect(attachUpgradeItem)
	
	
var upgradeList = [
		#{"sword" :  , "description": "It is a sword."},
]

'''
attachUpgradeItem
attach upgrade to attachment point on turtle
	var itemName: string
'''
func attachUpgradeItem(source, itemName):
	upgrade_dict["sword"] += 1
	print(upgrade_dict["sword"])
	for x in upgrade_list:
		if x == "sword":
			actual_upgrades.append(sword_scene.instantiate())
		elif x == "mace":
			actual_upgrades.append(mace_scene.instantiate())
			#mace.autoplay() #need to determine how to autoplay each instance
			
	var upgrade_spawn = source.get_node("Center")
	var num_items = upgrade_list.count(itemName)
	for i in range(num_items):
		actual_upgrades[i].position = upgrade_spawn.position + Vector2(0,-100)\
		.rotated((i + 1) * 2 * PI / num_items)
		actual_upgrades[i].rotation = ((i + 1) *2 * PI) / num_items
		source.add_collision_exception_with(actual_upgrades[i])
		source.add_child(actual_upgrades[i])
