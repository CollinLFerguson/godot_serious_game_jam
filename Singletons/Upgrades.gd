extends Node

var sword_scene: PackedScene = preload("res://Upgrades/Sword/Sword.tscn")
var mace_scene: PackedScene = preload("res://Upgrades/Mace/Mace.tscn")
var stars_scene: PackedScene = preload("res://Upgrades/ThrowingStars/ThrowingStars.tscn")


var upgrade_dict = {
		"sword": {"description" : "It is a sword.", "scene": sword_scene },
		"mace": {"description" : "It is a mace.", "scene": mace_scene },
		"stars": {"description" : "These are throwing stars.", "scene": stars_scene },
	}

var actual_upgrades = []
var upgrade_item = ""

func _ready() -> void:
	SignalBus.upgrade_selected.connect(setUpgradeItem)
	SignalBus.load_upgrade.connect(attachUpgradeItem)

func setUpgradeItem(itemName):
	upgrade_item = itemName

func createItemInstantiations(itemName, count):
	for c in count:
		actual_upgrades.append(upgrade_dict[itemName]["scene"].instantiate())
	for a in actual_upgrades:
		a.get_node("AnimatedSprite2D").play()
		
'''
attachUpgradeItem
attach upgrade to attachment point on turtle
	var source: node (parent signalling for upgrade attachment)
	var itemName: string
'''
func attachUpgradeItem(source):
	var num_items = 2
	var itemName = upgrade_item
	createItemInstantiations(itemName, num_items)
	
	var upgrade_spawn_1 = source.get_node("LeftHand")
	var upgrade_spawn_2 = source.get_node("RightHand")
	var spawn_points = [upgrade_spawn_1, upgrade_spawn_2]
	
	for i in range(num_items):
		actual_upgrades[i].position = spawn_points[i].position + Vector2(0,-100)
		source.add_collision_exception_with(actual_upgrades[i])
		source.add_child(actual_upgrades[i])
