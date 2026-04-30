extends Control

@export var debugLabel:Label

func _process(_delta: float) -> void:
	
	var debugText:String = str(
		"Velocity -> ", CurrentPlayer.velocity.floor(), "\n",
		"Position -> ", CurrentPlayer.position.floor(), "\n",
		"State -> ", CurrentPlayer.stateManager.currentState, "\n",
		"Last speed  -> ", floorf(CurrentPlayer.lastSpeed), "\n",
		"Coyote Time -> ", floorf(CurrentPlayer.coyoteTime)
	)
	
	debugLabel.text = debugText
	
	return
