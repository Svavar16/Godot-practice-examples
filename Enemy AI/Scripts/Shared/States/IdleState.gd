extends State

@onready var stateMachine: StateMachine

func _ready():
	stateMachine = get_parent()

# func _input(_event):
func _physics_process(_delta):
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction:
		stateMachine.on_child_transition(self, "WalkState")
	elif Input.is_action_pressed("Attack"):
		stateMachine.on_child_transition(self, "AttackState")
		# this needs to be in a process function, so we can have the correct state
	elif Input.is_action_just_pressed("ui_accept") && stateMachine.character.velocity.y < 0:
		stateMachine.on_child_transition(self, "JumpState")

