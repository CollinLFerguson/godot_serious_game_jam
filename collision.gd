extends CollisionPolygon2D

## A thin rectangular map border.
##
## This node MUST be a child of a StaticBody2D (or other CollisionObject2D).
## Set `map_s ize` and the four-wall outline builds itself; change it at runtime
## and it rebuilds.

@export var map_size: Vector2 = Vector2(1920, 1080):
	set(value):
		map_size = value
		if is_node_ready():
			rebuild()


func _ready() -> void:
	# Outline mode: Godot links the points into thin walls and closes the loop.
	build_mode = CollisionPolygon2D.BUILD_SEGMENTS
	rebuild()
	for x in polygon:
		print(x)
	#print(self.polygon.size())


## The four corners of the map area, in local space.
func rebuild() -> void:
	var w := map_size.x
	var h := map_size.y
	var padding = 100
	polygon = PackedVector2Array([
		Vector2(padding, padding),
		Vector2(w - padding, padding),
		Vector2(w - padding, h - padding),
		Vector2(padding, h - padding),
	])
