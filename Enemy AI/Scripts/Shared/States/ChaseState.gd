extends State
class_name ChaseState

@export var speed: float = 150.0

@onready var state_machine: StateMachine = get_parent()
var target: CharacterBody2D

func Enter() -> void:
	if state_machine.anim_player:
		if state_machine.anim_player.has_animation("Run"):
			state_machine.anim_player.play("Run")
		elif state_machine.anim_player.has_animation("walk"):
			state_machine.anim_player.play("walk")

func Physics_Update(_delta: float) -> void:
	var character = state_machine.character
	if not character or not target:
		return

	var direction = (target.global_position - character.global_position).normalized()
	character.velocity.x = direction.x * speed

func set_target(new_target: CharacterBody2D) -> void:
	target = new_target
