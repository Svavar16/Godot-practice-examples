class_name HurtComponent

extends Area2D

var healthComponent: HealthComponent

func _init():
	collision_layer = 0
	collision_mask = 8

func _ready():
	# Here the owner is the root node in the scene, in this case the Player and enemies respectively
	healthComponent = owner.get_node('HealthComponent')
	connect("area_entered", _on_area_entered)
	

func _on_area_entered(hitbox: HitComponent):
	if hitbox == null:
		return
	else:
		healthComponent._take_damage(hitbox.damage)
