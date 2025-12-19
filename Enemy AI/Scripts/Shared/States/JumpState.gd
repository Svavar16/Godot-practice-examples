extends State

class_name JumpState

@onready var stateMachine: StateMachine

func _ready():
	stateMachine = get_parent()

func Enter():
	if stateMachine and stateMachine.anim_player:
		var ap = stateMachine.anim_player
		if ap.has_animation("jump"):
			ap.play("jump")
		elif ap.has_animation("Jump"):
			ap.play("Jump")

func Physics_Update(_delta):
	if stateMachine.character and stateMachine.character.is_on_floor():
		var direction = 0.0
		if stateMachine.character.has_method("get_movement_direction"):
			direction = stateMachine.character.get_movement_direction()
		
		if direction != 0:
			emit_signal("Transitioned", self, "WalkState")
		else:
			emit_signal("Transitioned", self, "IdleState")
	elif stateMachine.character and stateMachine.character.velocity.y > 0.0:
		emit_signal("Transitioned", self, "FallState")
