extends Node

const HIT_EFFECT: PackedScene = preload("res://art/sparks/spark_impact.tscn")
const BOMBA_EFFECT: PackedScene = preload("res://art/explosion/explosion.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func throwSparksParticle(source):
	#TODO: This should be the branching point for a particleHandler.
	var effect = HIT_EFFECT.instantiate()
	source.add_sibling(effect)
	effect.global_position = source.position  # sits at the parent's origin and rides along
	effect.global_rotation = source.transform.get_rotation()
	effect.play()
	
func throwExplosionParticle(source):
	var effect = BOMBA_EFFECT.instantiate()
	source.add_sibling(effect)
	effect.global_position = source.position  # sits at the parent's origin and rides along
	#effect.global_rotation = source.transform.get_rotation()
	effect.play()
	
