class_name HealthComponent

extends Node

signal health_changes

@export var max_health: int = 3
var current_health: int

func _ready():
	current_health = max_health
	
func _take_damage(damage: int):
	current_health -= damage
	
	if current_health <= 0:
		owner.queue_free()
