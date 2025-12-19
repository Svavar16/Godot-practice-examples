extends CharacterBody2D

@onready var stateMachine: StateMachine

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite = $Sprite2D
# @onready varhitbox = $Hitbox

func _physics_process(delta):	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_jumping() and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = get_movement_direction()
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction < 0:
		sprite.flip_h = true
	elif direction > 0:
		sprite.flip_h = false

	move_and_slide()

func get_movement_direction() -> float:
	return Input.get_axis("ui_left", "ui_right")

func is_jumping() -> bool:
	return Input.is_action_just_pressed("ui_accept")
