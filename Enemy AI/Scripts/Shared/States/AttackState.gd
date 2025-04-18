extends State

class_name AttackState

@onready var stateMachine: StateMachine

func _ready():
	stateMachine = get_parent()


func _on_animation_player_animation_finished(_anim_name):
	stateMachine.on_child_transition(self, "IdleState")
