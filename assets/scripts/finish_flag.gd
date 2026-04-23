class_name FinishFlag extends Node2D

@export var flagArea:Area2D
@export var levelMusic:AudioStreamPlayer

var completed:bool = false

func _bodyEntered(body:Node) -> void:
	
	if body != CurrentPlayer:
		return
		
	if completed:
		return
		
	completed = true
	levelMusic.seek(165.59)
	CurrentPlayer.stateManager.switchState("actor")
	ScoreManager.levelEnded = Time.get_unix_time_from_system()
	ScoreManager.levelTimeRemaining = ScoreManager.levelTimer.time_left
	ScoreManager.levelTimer.stop()
	$AnimatedSprite2D.play("finished")
	
	await get_tree().create_timer(8).timeout
	get_tree().change_scene_to_file("res://assets/scenes/title.tscn")
	return
	
func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	flagArea.body_entered.connect(_bodyEntered)
	return
