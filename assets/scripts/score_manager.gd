class_name ClassScoreManager extends Node

@export var coinCollected:AudioStreamPlayer
@export var levelTimer:Timer

var currentScore:int = 0
var levelBegan:float
var levelEnded:float
var levelTimeRemaining:float

var collectedCoins:Array[String] = []
var levelCurrent:String
var levelBests:Dictionary[String, Dictionary] = {}


func _levelTimeout() -> void:
	get_tree().change_scene_to_file("res://assets/scenes/title.tscn")
	return

func _ready() -> void:
	levelTimer.timeout.connect(_levelTimeout)
	return


func _unhandled_input(_event: InputEvent) -> void:
	
	if !Input.is_action_just_pressed("reset"):
		return
		
	get_tree().change_scene_to_file("res://assets/scenes/title.tscn")
	return
