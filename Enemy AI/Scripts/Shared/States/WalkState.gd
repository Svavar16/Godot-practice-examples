extends State

class_name WalkState

@onready var stateMachine: StateMachine

func _ready():
	stateMachine = get_parent()

func _physics_process(delta):
	if stateMachine.character.velocity == Vector2.ZERO:
		Transitioned.emit(self, "IdleState")
		
