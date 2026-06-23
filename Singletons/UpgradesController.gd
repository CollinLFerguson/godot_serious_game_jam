extends Node

var sword_scene: PackedScene = preload("res://Upgrades/Sword/Sword.tscn")
var mace_scene: PackedScene = preload("res://Upgrades/Mace/Mace.tscn")
var stars_scene: PackedScene = preload("res://Upgrades/ThrowingStars/ThrowingStars.tscn")

var UPGRADES = {
		"sword": {
			"description" : "It is a sword.",
		 	"scene": sword_scene,
			"attach_points":["LeftHand", "RightHand", "LeftFoot", "RightFoot"]
		},
		"mace": {
			"description" : "It is a mace.", 
			"scene": mace_scene ,
			"attach_points":["LeftHand", "RightHand", "LeftFoot", "RightFoot"]
		},
		"stars": {
			"description" : "These are throwing stars.", 
			"scene": stars_scene ,
			"attach_points":["LeftHand", "RightHand", "LeftFoot", "RightFoot"]
		},
	}

func _ready() -> void:
	SignalBus.upgrade_selected.connect(setUpgradeItem)
	SignalBus.load_upgrades.connect(attachUpgradeItem)

func setUpgradeItem(itemName):
	#upgrade_item = itemName
	pass
		
func getSourceAttachPoints(source):
	var attach_collection = source.get_node("AttachPoints")
	if(attach_collection == null):
		return []
	return attach_collection.get_children()
	
func createItemInstantiation(item_name):
	var upgrade = null
	if(UPGRADES.has(item_name)):
		upgrade = UPGRADES[item_name]["scene"].instantiate()
	return upgrade
'''
attachUpgradeItem
attach upgrade to attachment point on turtle
	var source: node (parent signalling for upgrade attachment)
	var itemName: string
'''

func attachUpgradeItem(source, upgrade_identifiers):
	var source_attach_points = getSourceAttachPoints(source)
	print(upgrade_identifiers)
	for item_name in upgrade_identifiers:
		var item = createItemInstantiation(item_name)
		var valid_attach_points = UPGRADES[item_name]["attach_points"]
		
		for i in range(source_attach_points.size()):
			var attach_point = source_attach_points[i]
			if attach_point.name in valid_attach_points:
				print(attach_point.name + " " + item.name)
				attachAndTransform(source, attach_point, item)
				source.add_collision_exception_with(item)
				source_attach_points.remove_at(i)
				break
	
func attachAndTransform(parent_node, parent_attach_point, child_node):
	parent_node.add_child(child_node)
	var parent_transform = parent_attach_point.transform
	var child_attach_point = child_node.get_node("AttachPoint")
	var child_transform = Transform2D.IDENTITY #a 'null' transform if you will
	if(child_attach_point != null):
		child_transform = child_attach_point.transform
	child_node.transform = parent_transform * child_transform.inverse()
