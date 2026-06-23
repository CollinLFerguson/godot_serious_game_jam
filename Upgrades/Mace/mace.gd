extends StaticBody2D

@export var damage = 8
@export var weight = 15

func _ready():
	$AnimatedSprite2D.play()
