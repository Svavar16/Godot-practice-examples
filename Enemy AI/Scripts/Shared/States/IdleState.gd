extends State

class_name IdleState

@onready var stateMachine: StateMachine

func _input(event):
	if Input.get_axis("ui_left", "ui_right"):
		Transitioned.emit(self, "WalkState")
		#stateMachine.on_child_transition(self, "WalkState")
	elif Input.is_action_pressed("Attack"):
		Transitioned.emit(self, "AttackState")
		#stateMachine.on_child_transition(self, "AttackState")
