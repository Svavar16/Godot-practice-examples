extends CharacterBody2D

@onready var sprite = $Sprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var detection_area: Area2D = $DetectionArea
@onready var attack_area: Area2D = $AttackArea
@onready var line_of_sight: RayCast2D = $LineOfSight

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var direction = 1
var player_target: Node2D = null

func _ready() -> void:
	detection_area.body_entered.connect(_on_detection_area_body_entered)
	detection_area.body_exited.connect(_on_detection_area_body_exited)
	attack_area.body_entered.connect(_on_attack_area_body_entered)
	attack_area.body_exited.connect(_on_attack_area_body_exited)

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_target = body

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_target = null
		var chase_state = state_machine.states.get("ChaseState")
		if chase_state:
			chase_state.set_target(null)
		state_machine.on_child_transition(state_machine.current_state, "PatrolState")

func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		# We'll check LOS in physics_process to transition to attack
		pass

func _on_attack_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Player left AttackArea!")
		# If the player leaves the attack area but we still have LOS,
		# the enemy should go back to chasing.
		if state_machine.current_state.name == "AttackState":
			state_machine.on_child_transition(state_machine.current_state, "ChaseState")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if player_target:
		line_of_sight.target_position = line_of_sight.to_local(player_target.global_position)
		line_of_sight.force_raycast_update()
		
		var can_see := false
		if line_of_sight.is_colliding():
			var collider = line_of_sight.get_collider()
			if collider == player_target:
				can_see = true
		else:
			# Raycast didn't hit anything, meaning path is clear to target_position
			can_see = true
			
		if can_see:
			# We see the player!
			if state_machine.current_state.name == "PatrolState":
				var chase_state = state_machine.states.get("ChaseState")
				if chase_state:
					chase_state.set_target(player_target)
					state_machine.on_child_transition(state_machine.current_state, "ChaseState")
			
			# Check if we should attack
			if attack_area.get_overlapping_bodies().has(player_target):
				if state_machine.current_state.name == "ChaseState":
					state_machine.on_child_transition(state_machine.current_state, "AttackState")
		else:
			# LOS is blocked
			if state_machine.current_state.name == "ChaseState":
				state_machine.on_child_transition(state_machine.current_state, "PatrolState")

	move_and_slide()
	
	if velocity.x > 0:
		sprite.flip_h = true
	elif velocity.x < 0:
		sprite.flip_h = false

func get_movement_direction() -> float:
	return direction

func is_jumping() -> bool:
	return false
