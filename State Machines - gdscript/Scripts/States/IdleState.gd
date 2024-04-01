extends State
class_name IdleState

@onready var anim_player: AnimatedSprite2D = $"../../AnimatedSprite2D"

func Enter():
	anim_player.play("IdleState")
	
