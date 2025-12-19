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
            states[child.name] = child
            child.Transitioned.connect(on_child_transition)

    if initial_state:
        _set_state(initial_state)

func _process(delta):
    if current_state:
        current_state.Update(delta)

func _physics_process(delta):
    if current_state:
        current_state.Physics_Update(delta)

func on_child_transition(state: State, new_state_name: String) -> void:
    if state != current_state:
        return

    var new_state: State = states.get(new_state_name)
    if new_state == null:
        return
    if current_state == new_state:
        return
    _set_state(new_state)

func _set_state(new_state: State) -> void:
    if current_state:
        current_state.Exit()
    current_state = new_state
    current_state.Enter()
    if anim_player != null and current_state != null:
        if anim_player.has_animation(current_state.name):
            anim_player.play(current_state.name)
