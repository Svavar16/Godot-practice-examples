extends Node

@export var initial_state: State
@export var character: CharacterBody2D

var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitoned.connect(on_child_transition)
	
	if initial_state:
		initial_state.Enter()
		current_state = initial_state
  

func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if Input.get_axis("ui_left","ui_right"):
		on_child_transition(current_state, "WalkState")
	elif Input.is_action_pressed("ui_select"):
		on_child_transition(current_state, "JumpState")
	else:
		on_child_transition(current_state, "IdleState")
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state: State, new_state_name: String):
	if state != current_state:
		return

	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return

	if current_state:
		current_state.Exit()

	new_state.Enter()

	current_state = new_state
