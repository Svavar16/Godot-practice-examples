extends State
class_name JumpState

# since the animation node is even above the parent, we need to double track back and then we can play it
@onready var anim_player: AnimatedSprite2D = $"../../AnimatedSprite2D"

func Enter():
  anim_player.play("Jump")
  pass

func Exit():
  pass

func Update(delta: float):
  pass
