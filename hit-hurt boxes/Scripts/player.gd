extends CharacterBody2D

const SPEED: float = 300.0

@onready var sprite: Sprite2D = $"Sprite2D"
@onready var hitBox: CollisionShape2D = $"HitComponent/CollisionShape2D"

signal  facing_direction_changed

func _physics_process(delta):
	move_and_slide()

func _input(event):
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0,SPEED)
	
	if velocity.x > 0:
		sprite.flip_h = false
		hitBox.position = Vector2(25, 7)
	elif velocity.x < 0:
		sprite.flip_h = true
		hitBox.position = Vector2(-25, 7)


