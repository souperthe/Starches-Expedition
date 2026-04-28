extends Node2D


func _ready() -> void:
	
	var currentTime:float = ScoreManager.levelEnded - ScoreManager.levelBegan
	$CanvasLayer/Control/Label.text = "last coins: " + str(ScoreManager.currentScore) + "\nlast time: " + str(floorf(currentTime))   + "\nlast time remaing: " + str(floorf(ScoreManager.levelTimeRemaining)) + "\nlast total score: " + str(floorf(ScoreManager.levelTimeRemaining * ScoreManager.currentScore)) + "\n\npress any key to begin"
	
	CurrentPlayer.hide()
	CurrentPlayer.visible = false
	CurrentPlayer.hudLayer.visible = false
	CurrentPlayer.reset()
	MusicManager.songStop()
	return


func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		return
		
	if event is InputEventMouseButton:
		return
		
	CurrentPlayer.visible = true
		
	EntranceManager.currentEntrance = "START"
	CurrentPlayer.reset()
	get_tree().change_scene_to_file("uid://dep758rl8i2ty")
	return
