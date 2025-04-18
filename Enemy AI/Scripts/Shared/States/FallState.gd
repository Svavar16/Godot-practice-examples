extends State

class_name FallState

@onready var stateMachine: StateMachine

# Called when the node enters the scene tree for the first time.
func _ready():
  stateMachine = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
  if stateMachine.character.is_on_floor():
    stateMachine.on_child_transition(self, "IdleState")
