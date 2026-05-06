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
	
	if Input.is_action_just_pressed("reset"):
		get_tree().change_scene_to_file("res://assets/scenes/title.tscn")
		return
		
	if Input.is_action_just_pressed("fullscreen"):
		var modeCurrent:DisplayServer.WindowMode = DisplayServer.window_get_mode()
		var modeTarget:DisplayServer.WindowMode = DisplayServer.WindowMode.WINDOW_MODE_WINDOWED
		
		if modeCurrent == DisplayServer.WindowMode.WINDOW_MODE_WINDOWED:
			modeTarget = DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN
			
		DisplayServer.window_set_mode(modeTarget)
		return
		
	return
