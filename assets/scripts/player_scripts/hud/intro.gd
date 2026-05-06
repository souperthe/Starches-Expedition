class_name HudIntro extends Control

@export var animator:AnimationPlayer

func _introFinished() -> void:
	ScoreManager.levelTimer.start()
	ScoreManager.levelBegan = Time.get_ticks_msec()
	
	for player in PlayerManager.players:
		player.stateManager.switchState("idle")
		player.runPhysics = true
		continue
		
	return
	
func _introPlay() -> void:
	show()
	animator.play("play_intro")
	
	var currentLevel:Level = get_tree().current_scene
	
	ScoreManager.levelTimer.wait_time = currentLevel.levelTime
	
	for player in PlayerManager.players:
		player.stateManager.switchState("actor")
		player.velocity = Vector2.ZERO
		player.animationManager.animationPlay("level_start", 0.3)
		continue
		
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
