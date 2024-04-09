extends State

@onready var stateMachine: StateMachine

func _ready():
	stateMachine = get_parent()

func Enter():
	#stateMachine.anim_player.play("WalkState")
	pass

func _input(event):
	if Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):
		stateMachine.on_child_transition(self, "IdleState")

# Idle needs to be in the physics process, since we need to check periodically if the user has no input
#func _physics_process(delta):
	#if stateMachine.character.velocity == Vector2.ZERO:
		#
