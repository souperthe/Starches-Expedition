extends Node2D


func _ready() -> void:
	
	var currentTime:float = ScoreManager.levelEnded - ScoreManager.levelBegan
	$CanvasLayer/Control/Label.text = "last coins: " + str(ScoreManager.currentScore) + "\nlast time: " + str(currentTime)   + "\nlast time remaing: " + str(ScoreManager.levelTimeRemaining) + "\n\npress any key to begin"
	
	
	ScoreManager.currentScore = 0
	CommonSignals.updateCoins.emit(0)
	CurrentPlayer.hide()
	return


func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		return
		
	if event is InputEventMouseButton:
		return
		
	CurrentPlayer.show()
		
	EntranceManager.currentEntrance = "START"
	get_tree().change_scene_to_file("res://assets/scenes/node.tscn")
	return
