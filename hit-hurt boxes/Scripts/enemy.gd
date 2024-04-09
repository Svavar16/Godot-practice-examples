extends CharacterBody2D

@export var health: int = 100

# this function would be part of the health component
func take_damage(damage: int):
	health -= damage
	
	if health <= 0:
		queue_free()
