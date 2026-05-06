extends Control

@export var debugLabel:Label

func _ready() -> void:
	
	if OS.is_debug_build():
		return
		
	queue_free()
	return

func _process(_delta: float) -> void:
	
	var firstPlayer:Player = PlayerManager.players[0]
	var debugText:String = str(
		"Velocity -> ", firstPlayer.velocity.floor(), "\n",
		"Position -> ", firstPlayer.position.floor(), "\n",
		"State -> ", firstPlayer.stateManager.currentState, "\n",
		"Last speed  -> ", floorf(firstPlayer.lastSpeed), "\n",
		"Coyote Time -> ", floorf(firstPlayer.coyoteTime)
	)
	
	debugLabel.text = debugText
	
	return
