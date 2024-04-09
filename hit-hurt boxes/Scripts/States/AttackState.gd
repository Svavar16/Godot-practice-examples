extends State

@onready var stateMachine: StateMachine

func _ready():
	stateMachine = get_parent()

# this basically lets our statemachine know that the animation has finished, and it should go into idle state
func _on_animation_player_animation_finished(anim_name):
	stateMachine.on_child_transition(self, "IdleState")
