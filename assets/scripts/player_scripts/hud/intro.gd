class_name HudIntro extends Control

@export var animator:AnimationPlayer

func _introFinished() -> void:
	CurrentPlayer.stateManager.switchState("idle")
	ScoreManager.levelTimer.start()
	ScoreManager.levelBegan = Time.get_unix_time_from_system()
	return
	
func _introPlay() -> void:
	show()
	animator.play("play_intro")
	CurrentPlayer.stateManager.switchState("actor")
	CurrentPlayer.velocity = Vector2.ZERO
	CurrentPlayer.animationManager.animationPlay("level_start", 0.3)
	return
	
func _entranceSent(entrance:String) -> void:
	
	if entrance != "start":
		return
		
	_introPlay()
	return

func _ready() -> void:
	hide()
	
	CommonSignals.sentToEntrance.connect(_entranceSent)
	
	return
