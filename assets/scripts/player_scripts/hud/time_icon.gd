extends Control

@export var timerLabel:Label

func _process(_delta: float) -> void:
	var flooredTime:float = floorf(ScoreManager.levelTimer.time_left)
	timerLabel.text = str(int(flooredTime))
	return

func _ready() -> void:
	return
