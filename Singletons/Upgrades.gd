extends Node

var sword_scene: PackedScene = preload("res://Upgrades/Sword/Sword.tscn")
var mace_scene: PackedScene = preload("res://Upgrades/Mace/Mace.tscn")

@onready var mace = get_node("/root/Upgrades/Mace")

var upgrade_dict = {
		"sword": {"description" : "It is a sword.", "scene": sword_scene },
		"mace": {"description" : "It is a mace.", "scene": mace_scene },
	}

var actual_upgrades = []

func _ready() -> void:
	SignalBus.upgrade_selected.connect(attachUpgradeItem)


func createItemInstantiations(itemName, count):
	for c in count:
		actual_upgrades.append(upgrade_dict[itemName]["scene"].instantiate())

'''
attachUpgradeItem
attach upgrade to attachment point on turtle
	var source: node (parent signalling for upgrade attachment)
	var itemName: string
'''
func attachUpgradeItem(source, itemName):
	var num_items = 2
	createItemInstantiations(itemName, num_items)
	
	var upgrade_spawn_1 = source.get_node("LeftHand")
	var upgrade_spawn_2 = source.get_node("RightHand")
	var spawn_points = [upgrade_spawn_1, upgrade_spawn_2]
	
	for i in range(num_items):
		actual_upgrades[i].position = spawn_points[i].position + Vector2(0,-100)
		source.add_collision_exception_with(actual_upgrades[i])
		source.add_child(actual_upgrades[i])
