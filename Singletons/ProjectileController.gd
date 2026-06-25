extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func isProjectile(source):
	if source.is_in_group("projectile"):
		return true
	else:
		return false
	
#func trigger_projectile_decay(source):
	#check that the source is in the projectile group
	#if isProjectile(source):
		
	# if a projectile has been spawned
		# log the number of collisions it makes, 
	# if collision count > 3
	# free the item/ remove it from the screen
