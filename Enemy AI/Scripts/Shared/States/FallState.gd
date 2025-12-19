extends State

class_name FallState

@onready var stateMachine: StateMachine

# Called when the node enters the scene tree for the first time.
func _ready():
	stateMachine = get_parent()

func Enter():
	if stateMachine and stateMachine.anim_player:
		var ap = stateMachine.anim_player
		if ap.has_animation("fall"):
			ap.play("fall")
		elif ap.has_animation("Fall"):
			ap.play("Fall")
		elif ap.has_animation("jump"):
			ap.play("jump") # Fallback to jump if no fall animation
		elif ap.has_animation("Jump"):
			ap.play("Jump")


func Physics_Update(_delta):
	if stateMachine.character.is_on_floor():
		var direction = 0.0
		if stateMachine.character.has_method("get_movement_direction"):
			direction = stateMachine.character.get_movement_direction()
		
		if direction != 0:
			emit_signal("Transitioned", self, "WalkState")
		else:
			emit_signal("Transitioned", self, "IdleState")
