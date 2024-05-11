extends Node2D

# this is just so see the actual effect
@onready var label: Label = $"Label"
@onready var ticker: Timer = $"Ticker"

var labelValue: int = 0;

func _ready():
  # for tat we have a simple timer
  ticker.connect("timeout", _on_timer_tick)
  ticker.wait_time = 1
  ticker.start()

# which runs this function every second
func _on_timer_tick():
  labelValue += 1
  label.text = "Game: %d" % labelValue
