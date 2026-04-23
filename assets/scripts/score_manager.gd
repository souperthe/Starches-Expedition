class_name ClassScoreManager extends Node

@export var coinCollected:AudioStreamPlayer
@export var levelTimer:Timer

var currentScore:int = 0
var levelBegan:float
var levelEnded:float


func _levelTimeout() -> void:
	get_tree().change_scene_to_file("res://assets/scenes/title.tscn")
	return

func _ready() -> void:
	levelTimer.timeout.connect(_levelTimeout)
	return
