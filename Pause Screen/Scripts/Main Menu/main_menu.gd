extends Control

# a simple main menu script, not much to see here

@onready var start_button: Button = $"VBoxContainer/Start"
@onready var options_button: Button = $"VBoxContainer/Options"
@onready var exit_button: Button = $"VBoxContainer/Exit"


func _ready():
  start_button.pressed.connect(_on_start_pushed)
  options_button.pressed.connect(_on_options_pushed)
  exit_button.pressed.connect(_on_exit_pushed)

# here it might be a good idea, for when the user saves and loads the game, to show the level that the user was on, instead of loading just level 1
func _on_start_pushed():
  get_tree().change_scene_to_file("res://Scenese/Levels/level1.tscn")

func _on_options_pushed():
	# get_tree().change_scene_to_file("res://Scenes/Menu/menu.tscn")
  pass

func _on_exit_pushed():
  get_tree().quit()
  pass
