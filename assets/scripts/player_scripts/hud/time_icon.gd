extends Control

@export var timerLabel:Label

func _process(_delta: float) -> void:
	var flooredTime:float = floorf(ScoreManager.levelTimer.time_left)
	var intTime:int = int(flooredTime)
	
	if intTime == 0:
		return
		
	timerLabel.text = str(intTime)
	return

func _ready() -> void:
	return
