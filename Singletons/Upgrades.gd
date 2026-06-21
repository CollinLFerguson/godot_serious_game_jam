extends Node

func _ready() -> void:
	SignalBus.upgrade_selected.connect(attachUpgradeItem)
	
	
#var upgradeList = [
		#{"sword" :  , "description": "It is a sword."},
	#]

'''
attachUpgradeItem
attach upgrade to attachment point on turtle
	var itemName: string
'''
func attachUpgradeItem(source, itemName):
	
	var leftHand = source.get_node("AttachPointLeft")
	var item = leftHand.get_node(itemName)
	var itemGrip = item.get_node("AttachPoint")
	
	item.global_position += (
		leftHand.global_position - itemGrip.global_position
	)
	
	#grab item from upgrade list with corresponding tag
	#figure out how to determine parent that called it
	#connect item using attach point left and right
	#upgradeList[0][itemName].global_position = source.position
	pass
	

#dictionary of upgrades -- item, description, any other pertinent info

# functions to handle types of items ex: thrown vs melee vs combo vs defense
