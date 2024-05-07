extends Node

const SETTINGS_SAVE_PATH: String = "user://settingsData.save"

var setting_data_dic: Dictionary = {}

# func _ready():
  # so if you watched the video, this is where you could connect to the function to save the settings.
  # pass

# this is how I intend to do it for now, should work
func save_settings_data(data: Dictionary) -> void:
  var file = FileAccess.open(SETTINGS_SAVE_PATH, FileAccess.WRITE)
  if file:
    print(file)
    file.store_line(JSON.stringify(data))
    file.close()

