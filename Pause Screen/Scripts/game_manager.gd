extends Node

# the signel which will tell our game manager if the game has been paused or not
signal toogle_game_paused(is_paused: bool)

func _ready():
  # since we are not using this as a scene, we need to add this part, this makes it so that this script will always run
  # not matter what
  process_mode = Node.PROCESS_MODE_ALWAYS

## the actual paused variable, with a getter and setter
var game_paused: bool = false:
  get:
    return game_paused
  set(value):
    # print("game paused: ", value)
    game_paused = value
    get_tree().paused = game_paused
    emit_signal("toogle_game_paused", game_paused)

func _input(event: InputEvent): 
  if (event.is_action_pressed("ui_cancel")):
    game_paused = !game_paused
