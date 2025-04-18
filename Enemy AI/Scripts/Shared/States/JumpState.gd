extends State

class_name JumpState

@onready var stateMachine: StateMachine

# Called when the node enters the scene tree for the first time.
func _ready():
	stateMachine = get_parent()

func _physics_process(_delta):
	if stateMachine.character.is_on_floor():
		stateMachine.on_child_transition(self, "IdleState")
	elif stateMachine.character.velocity.y > 0:
		stateMachine.on_child_transition(self, "FallState")
