extends State

@onready var stateMachine: StateMachine

func _input(event):
	if Input.get_axis("ui_left", "ui_right"):
		Transitoned.emit(self, "WalkState")
		#stateMachine.on_child_transition(self, "WalkState")
	elif Input.is_action_pressed("Attack"):
		Transitoned.emit(self, "AttackState")
		#stateMachine.on_child_transition(self, "AttackState")
