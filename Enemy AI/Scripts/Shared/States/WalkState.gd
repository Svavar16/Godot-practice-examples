extends State

class_name WalkState

@onready var stateMachine: StateMachine

func _ready():
	stateMachine = get_parent()

func _physics_process(_delta):
	if Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
		stateMachine.on_child_transition(self, "IdleState")
	elif Input.is_action_just_pressed("ui_accept"):
		stateMachine.on_child_transition(self, "JumpState")
	elif stateMachine.character.velocity.y > 0:
		print("walktState -> falling")
		stateMachine.on_child_transition(self, "FallState")
		