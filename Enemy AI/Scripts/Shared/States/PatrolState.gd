extends State
class_name PatrolState

@export var patrol_range: float = 200.0
@export var speed: float = 100.0

@onready var state_machine: StateMachine = get_parent()
@onready var ray_cast: RayCast2D

var start_position: Vector2
var initial_start_position: Vector2
var target_position: Vector2
var moving_right: bool = true
var first_enter: bool = true

func _ready() -> void:
	# Look for a RayCast2D child if it exists
	for child in get_children():
		if child is RayCast2D:
			ray_cast = child
			break

func Enter() -> void:
	if state_machine.character:
		if first_enter:
			initial_start_position = state_machine.character.global_position
			first_enter = false
		start_position = initial_start_position
		_update_target()
	
	if state_machine.anim_player:
		if state_machine.anim_player.has_animation("walk"):
			state_machine.anim_player.play("walk")
		elif state_machine.anim_player.has_animation("Run"):
			state_machine.anim_player.play("Run")

func Physics_Update(_delta: float) -> void:
	var character = state_machine.character
	if not character:
		return

	# Check for obstacles or edges using RayCast if available
	if ray_cast and ray_cast.is_colliding():
		# If it's a wall raycast, we should flip
		# If it's a floor raycast, we should flip if NOT colliding
		# For simplicity, let's assume if it collides with something while pointing forward, it's a wall.
		# If it's pointing down-forward and NOT colliding, it's an edge.
		# The user mentioned "this as a raycast", so let's allow them to drive the flip.
		_flip()

	var current_pos = character.global_position
	
	# Check if we reached the patrol limits
	if moving_right and current_pos.x >= start_position.x + patrol_range:
		_flip()
	elif not moving_right and current_pos.x <= start_position.x - patrol_range:
		_flip()

	var direction = 1.0 if moving_right else -1.0
	character.velocity.x = direction * speed
	
	# Update raycast direction
	if ray_cast:
		ray_cast.target_position.x = abs(ray_cast.target_position.x) * direction

func _flip() -> void:
	moving_right = !moving_right
	_update_target()

func _update_target() -> void:
	if moving_right:
		target_position = start_position + Vector2(patrol_range, 0)
	else:
		target_position = start_position - Vector2(patrol_range, 0)
