extends State

class_name AttackState

@onready var stateMachine: StateMachine

func _ready():
	stateMachine = get_parent()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "AttackState":
		Transitioned.emit(self, "IdleState")
