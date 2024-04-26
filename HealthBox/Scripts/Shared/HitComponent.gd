class_name HitComponent

extends Area2D

@export var damage: int = 1

func _init() -> void:
	collision_layer = 8
	collision_mask = 0
