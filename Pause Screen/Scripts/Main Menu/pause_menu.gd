extends Control

# the buttons that we are connecting to
@onready var return_to_game_button: Button = $"VBoxContainer/Return_to_game"
@onready var options_button: Button = $"VBoxContainer/Options"
@onready var quit_to_menu_button: Button = $"VBoxContainer/Quit_to_menu"

func _ready():
  GameManager.connect("toogle_game_paused", _on_game_manager_toggle_pause)
  return_to_game_button.pressed.connect(_on_return_to_game_pressed)
  options_button.pressed.connect(_on_options_pressed)
  quit_to_menu_button.pressed.connect(_on_quit_to_menu_pressed)

# when we start the game again, we just need to tell the game manager that the game is not paused any longer
func _on_return_to_game_pressed():
  GameManager.game_paused = false

# right now im just passing this, but here we would have the options menu
# could be another scene where we hide this, and show the options menu
func _on_options_pressed():
  # get_tree().change_scene_to_file("res://Scenes/Menu/menu.tscn")
  pass

func _on_quit_to_menu_pressed():
  get_tree().change_scene_to_file("res://Scenese/Menu/main_menu.tscn")

func _on_game_manager_toggle_pause(is_paused: bool):
  if is_paused:
    show()
  else:
    hide()

# func _input(event):
#   if(event.is_action_pressed("ui_cancel") && GameManager.game_paused == true):
#     GameManager.game_paused = false
