extends Control

# this here is just a base example, in reality, these should all be in their own files
# keybinding in their own, and the screen resolution in their own

# these are for the key bindings
var current_button: Button

@onready var AttackButton: Button = $"Attack"
@onready var AttackLabel: Label = $"Attack_Current"
@onready var InfoPanel: PanelContainer = $"PanelContainer"

# this is for the Window mode
@onready var optionsButton: OptionButton = $"OptionButton"
var screen_mode_index: int = 0

# This is for the Window Mode
@onready var resolutionOptions: OptionButton = $"ResolutionsOptions"
var screen_resolution_index: int = 0

# This is for the sound options
@onready var musicLabel: Label = $"HSlider/Label"
@onready var musicSlider: HSlider = $"HSlider"

var bus_index: int = 0

# save settings
@onready var saveButton: Button = $"SaveButton"

# if we had multible sound options then we could do something like this
@export_enum("Master", "Music") var busName: String

# these are the options that you can select within the window options
const WINDOW_MODE_ARRAY: Array[String] = [
  "Full-Screen",
  "Window mode",
  "Borderless Window",
  "Borderless Full-Screen"
]

# this is for the screen resolution

# these are the options for the screen resolution
const RESOLUTION_OPTIONS: Dictionary = {
  "1152 X 648": Vector2i(1152, 648),
  "1280 X 720": Vector2i(1280, 720),
  "1920 x 1080": Vector2i(1920, 1080)
}

func _ready():
  # these are for setting the new key binding
  AttackButton.pressed.connect(_on_button_pressed.bind(AttackButton))

  _update_label()

  InfoPanel.hide()
  
  # this is for the Window mode
  _add_window_mode_items()
  optionsButton.item_selected.connect(_on_window_mode_selected)

  # this is for the screen resolution
  _add_resolutions_screen_items()
  resolutionOptions.item_selected.connect(_on_screen_resolution_selected)

  musicSlider.value_changed.connect(_on_music_value_changed)
  get_bus_name_by_index()
  set_audo_num_label_text()
  set_slider_value()

  # so here we connect to the save button and have it save the state below
  saveButton.pressed.connect(_save_settings)

  _load_saved_data()

func _on_button_pressed(button: Button):
  current_button = button
  InfoPanel.show()

# this is used for the key binding
func _update_label():
  var eb1: Array[InputEvent] = InputMap.action_get_events("Attack")
  if !eb1.is_empty():
    AttackLabel.text = eb1[0].as_text()
  else:
    AttackLabel.text = ""


# this is used for the key binding
func _input(event: InputEvent) -> void:
  if !current_button:
    return
  
  if event is InputEventKey || event is InputEventMouseButton:
    var all_ies: Dictionary = {}
    for ia in InputMap.get_actions():
      for iak in InputMap.action_get_events(ia):
        all_ies[iak.as_text()] = ia

    if all_ies.keys().has(event.as_text()):
      InputMap.action_erase_events(all_ies[event.as_text()])

    InputMap.action_erase_events(current_button.name)
    InputMap.action_add_event(current_button.name, event)

    current_button = null
    InfoPanel.hide()
    _update_label()

# this is used for the Window mode
func _on_window_mode_selected(index: int) -> void:
  screen_mode_index = index
  match index:
    0: # Full-Screen
      DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
      DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
    1: # Window Mode
      DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
      DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
    2: # Borderless Window mode
      DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
      DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
    3: # Borderless Full-Screen
      DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
      DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
  # here we are setting the value, this should then be refrected within the application
  optionsButton.selected = index
    
func _add_window_mode_items() -> void:
  for window in WINDOW_MODE_ARRAY:
    optionsButton.add_item(window)

func _add_resolutions_screen_items() -> void:
  for resolution in RESOLUTION_OPTIONS:
    resolutionOptions.add_item(resolution)

func _on_screen_resolution_selected(index: int) -> void:
  screen_resolution_index = index
  DisplayServer.window_set_size(RESOLUTION_OPTIONS.values()[index])
  # here we are setting the value, this should then be refrected within the application
  resolutionOptions.selected = index

# These are all sound related functions
func _on_music_value_changed(value: float) -> void:
  # here we are setting the value, this should then be refrected within the application
  musicSlider.value = value
  AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
  set_audo_num_label_text()

# we dont have it here, but with this we could change the label to show which sound is used
# func set_music_name_label_text() -> void:
#   musicLabel.text = str(busName) + "Volume"

func get_bus_name_by_index() -> void:
  bus_index = AudioServer.get_bus_index(busName)

func set_audo_num_label_text() -> void:
  musicLabel.text = str(musicSlider.value)

func set_slider_value() -> void:
  musicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

func _save_settings() -> void:
  # while we use a dictonary here for this, it might not be the best solution
  # however, for this small example, we will do it like that
  var data: Dictionary = {
    "Music": musicSlider.value,
    "Window Mode": screen_mode_index,
    "Screen Resolution": screen_resolution_index,
    "Attack Button": InputMap.action_get_events("Attack")
  }

  # so here we call to actually save the data, using the SaveManager we have created
  SaveManager.save_settings_data(data)
  # so from here, we could create a save manager, this would also handle saving your game
  # and the to load the data, we would have a load manager

# this is a basic example, and this works as expected
func _load_saved_data() -> void:
  var data = LoadManager.load_data()
  print(data)
  _on_window_mode_selected(data.get("Window Mode"))
  _on_screen_resolution_selected(data.get("Screen Resolution"))
  _on_music_value_changed(data.get("Music"))
