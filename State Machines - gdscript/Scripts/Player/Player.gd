extends CharacterBody2D

func _physics_process(_delta):
  move_and_slide()


func _input(_event):
  var direction = Input.get_axis("ui_left","ui_right")
  if direction:
    velocity.x = direction * 300.0
  elif Input.is_action_pressed("ui_select"):
    velocity.y -= 300.0
  else:
    velocity.x = move_toward(velocity.x, 0, 300.0)
