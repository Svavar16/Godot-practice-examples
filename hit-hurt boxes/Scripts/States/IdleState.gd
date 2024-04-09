extends State

@onready var stateMachine: StateMachine

func _ready():
	stateMachine = get_parent()

func Enter():
	#stateMachine.anim_player.play("IdleState")
	pass

func _input(event):
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		stateMachine.on_child_transition(self, "WalkState")
	elif Input.is_action_pressed("Attack"):
		stateMachine.on_child_transition(self, "AttackState")
