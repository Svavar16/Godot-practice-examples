extends Control

# if using signals, we could do this
@onready var start_button = $"VBoxContainer/StartButton" as Button

# then we connect to the signals in the ready function
func _ready():
	handle_button_signals()

func _on_start_button_pressed():
	print("start")
	# so this is how the scene would be loaded
	# get_tree().change_scene_to_file("res://Scenes/Menu/menu.tscn")


func _on_options_button_pressed():
	print("Options")
	# this is how the options could be opened
	# var options = load("res://Scenes/Menu/menu.tscn")
	# get_tree().current_scene.add_child(options)
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()
	
# then this function would do the action
func on_start_pressed():
	print("Start")

# this could also be done with a signals
func handle_button_signals():
	start_button.button_down.connect(on_start_pressed)
