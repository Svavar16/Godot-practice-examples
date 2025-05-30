class_name StateMachine

extends Node

@export var initial_state: State
@export var character: CharacterBody2D
@export var anim_player: AnimationPlayer

var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)

	if initial_state:
		initial_state.Enter()
		anim_player.play(initial_state.name)
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.Update(delta)

func on_child_transition(state: State, new_state_name: String) -> void:
	if state != current_state:
		return

	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return

	if current_state:
		current_state.Exit()

	new_state.Enter()

	anim_player.play(new_state_name)

	current_state = new_state
