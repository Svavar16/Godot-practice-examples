class_name HurtComponent

extends Area2D

func _init():
	collision_layer = 0
	collision_mask = 8

func _ready():
	connect("area_entered", _on_area_entered)
	
func _on_area_entered(hitbox: HitComponent):
	if hitbox == null:
		return
		
	print("Damage")
	
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
