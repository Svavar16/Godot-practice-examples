extends State

@onready var stateMachine: StateMachine

func _ready():
	stateMachine = get_parent()

func Enter():
	if stateMachine and stateMachine.anim_player:
		var ap = stateMachine.anim_player
		if ap.has_animation("idle"):
			ap.play("idle")
		elif ap.has_animation("Idle"):
			ap.play("Idle")

func Physics_Update(_delta):
	if not stateMachine.character.is_on_floor():
		if stateMachine.character.velocity.y > 0:
			emit_signal("Transitioned", self, "FallState")
		else:
			emit_signal("Transitioned", self, "JumpState")
		return

	if stateMachine.character.has_method("is_jumping") and stateMachine.character.is_jumping():
		emit_signal("Transitioned", self, "JumpState")
		return

	var direction = 0.0
	if stateMachine.character.has_method("get_movement_direction"):
		direction = stateMachine.character.get_movement_direction()

	if direction != 0:
		emit_signal("Transitioned", self, "WalkState")
		return

	if stateMachine.character.has_method("is_attacking") and stateMachine.character.is_attacking():
		emit_signal("Transitioned", self, "AttackState")
		return

