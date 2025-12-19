extends State

class_name AttackState

@onready var stateMachine: StateMachine

@export var return_state: String = ""

func _ready():
	stateMachine = get_parent()

func Enter():
	if stateMachine and stateMachine.character:
		stateMachine.character.velocity.x = 0
	
	if stateMachine and stateMachine.anim_player:
		var ap = stateMachine.anim_player
		var played := false
		if ap.has_animation("attack"):
			ap.play("attack")
			played = true
		elif ap.has_animation("Attack"):
			ap.play("Attack")
			played = true
		if played and not ap.animation_finished.is_connected(_on_anim_finished):
			ap.animation_finished.connect(_on_anim_finished)

func Exit():
	if stateMachine and stateMachine.anim_player:
		var ap = stateMachine.anim_player
		if ap.animation_finished.is_connected(_on_anim_finished):
			ap.animation_finished.disconnect(_on_anim_finished)

func _on_anim_finished(anim_name: StringName) -> void:
	if String(anim_name).to_lower() == "attack":
		if return_state != "" and stateMachine.states.has(return_state):
			emit_signal("Transitioned", self, return_state)
			return

		var direction = 0.0
		if stateMachine.character.has_method("get_movement_direction"):
			direction = stateMachine.character.get_movement_direction()
		
		if direction != 0:
			emit_signal("Transitioned", self, "WalkState")
		else:
			emit_signal("Transitioned", self, "IdleState")
