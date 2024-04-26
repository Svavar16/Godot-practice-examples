extends CharacterBody2D

@onready var sprite: Sprite2D = $"Sprite2D"
@onready var hitBox: CollisionShape2D = $"HitComponent/CollisionShape2D"

func _physics_process(delta):
	move_and_slide()

func _input(event):
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * 300.0
	else:
		velocity.x = move_toward(velocity.x, 0, 300.0)
		
	_flip()

func _flip():
	if velocity.x > 0:
		sprite.flip_h = false
		hitBox.position = Vector2(26, 5)
	elif velocity.x < 0:
		sprite.flip_h = true
		hitBox.position = Vector2(-26, 5)
