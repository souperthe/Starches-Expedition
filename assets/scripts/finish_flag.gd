class_name FinishFlag extends Node2D

@export var flagArea:Area2D
@export var levelMusic:AudioStreamPlayer

var completed:bool = false

func _fadeSong() -> void:
	var musicTween:Tween = get_tree().create_tween()
	MusicManager.songEmitter.seek(MusicManager.songEndPosition)
	musicTween.tween_property(MusicManager.songEmitter, "volume_linear", 0, 6)
	return

func _bodyEntered(body:Node) -> void:
	
	if not(body is Player):
		return
		
	if completed:
		return
		
	completed = true
	
	
	body.stateManager.switchState("actor")
	ScoreManager.levelEnded = Time.get_ticks_msec()
	ScoreManager.levelTimeRemaining = ScoreManager.levelTimer.time_left
	
	var timeSpent:float = (ScoreManager.levelEnded - ScoreManager.levelBegan) / 1000.0
	var generalScore:float = ScoreManager.levelTimeRemaining * ScoreManager.currentScore
	
	print(timeSpent)
	
	var saveData:Dictionary[String, Variant] = {
		"coins": ScoreManager.currentScore,
		"time_remaining": snappedf(ScoreManager.levelTimer.time_left, 0.01),
		"time_spent": snappedf(timeSpent, 0.01),
		"general_score: ": int(generalScore)
	}
	
	ScoreManager.levelBests.erase(ScoreManager.levelCurrent)
	ScoreManager.levelBests[ScoreManager.levelCurrent] = saveData
	
	print("ScoreManager -> ", ScoreManager.levelCurrent, "'s data has been written")
	
	ScoreManager.levelTimer.stop()
	$AnimatedSprite2D.play("finished")
	
	_fadeSong()
	
	await get_tree().create_timer(7).timeout
	get_tree().change_scene_to_file("res://assets/scenes/title.tscn")
	return
	
func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	flagArea.body_entered.connect(_bodyEntered)
	return
