extends Node

const SETTINGS_SAVE_PATH: String = "user://settingsData.save"

var settings_data_dic: Dictionary = {}

# this function would be within the game manager, or something like that, so it would activate once the game is started
func load_data() -> Dictionary:
  var file = FileAccess.open(SETTINGS_SAVE_PATH, FileAccess.READ)
  if file:
    return JSON.parse_string(file.get_as_text())
  return {}
