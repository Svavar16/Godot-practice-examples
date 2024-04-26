extends State

@onready var stateMachine: StateMachine

func _ready():
	stateMachine = get_parent()


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "AttackState":
		Transitoned.emit(self, "IdleState")
