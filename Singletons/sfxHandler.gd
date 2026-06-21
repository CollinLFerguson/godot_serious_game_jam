extends Node

const HIT_EFFECT: PackedScene = preload("res://art/sparks/spark_impact.tscn")

func _ready():
	SignalBus.battle_start.connect(playBattleTheme)
	SignalBus.hit.connect(handleHitstop)
	SignalBus.hit.connect(handleParticles)
func playBattleTheme():
	pass

func handleHitstop(source, target):
	if target.is_in_group('scenery'):
		return
	#define more conditions here.
	HitstopManager.hitstop_short()

func handleParticles(source: Node2D, target) -> void:
	#TODO: This should be the branching point for a particleHandler.
	var effect = HIT_EFFECT.instantiate()
	get_tree().current_scene.add_child(effect)
	effect.global_position = source.position  # sits at the parent's origin and rides along
	effect.global_rotation = source.transform.get_rotation()
	effect.play()
