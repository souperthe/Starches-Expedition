class_name HudIntro extends Control

@export var animator:AnimationPlayer

func _introFinished() -> void:
	CurrentPlayer.stateManager.switchState("idle")
	return
	
func _introPlay() -> void:
	show()
	animator.play("play_intro")
	CurrentPlayer.stateManager.switchState("actor")
	return

func _ready() -> void:
	hide()
	
	CommonSignals.playIntro.connect(_introPlay)
	
	_introPlay()
	
	return
