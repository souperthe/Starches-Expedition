extends Node2D

@export var levels:Array[SelectableLevel]
@export var levelPortait:TextureRect
@export var levelStats:Label
@export var levelLabel:Label
@export var nudgeRight:TextureRect
@export var nudgeLeft:TextureRect
@export var fades:Control

var currentLevel:SelectableLevel
var currentIndex:int = 0
var selectionPressed:float = 0
var canInput:bool = true
var swipeTime:float = 0.4
var lastDirection:float = 1

func _enterLevel() -> void:
	canInput = false
	nudgeLeft.self_modulate.a = 0
	nudgeRight.self_modulate.a = 0
	
	var musicTween:Tween = get_tree().create_tween()
	musicTween.tween_property(MusicManager.songEmitter, "volume_linear", 0.2, 0.4)
	
	await get_tree().create_timer(0.5).timeout
	
	var growTween:Tween = get_tree().create_tween()
	var spinTween:Tween = get_tree().create_tween()
	var fadeTween:Tween = get_tree().create_tween()
	musicTween = get_tree().create_tween()
	musicTween.set_parallel(true)
	
	spinTween.tween_property(levelPortait, "rotation", 360*4, 90)
	growTween.tween_property(levelPortait, "scale", Vector2(5,5), 3)
	fadeTween.tween_property($CanvasLayer/Control/ColorRect, "color:a", 1, 1)
	musicTween.tween_property(MusicManager.songEmitter, "pitch_scale", 2, 1)
	musicTween.tween_property(MusicManager.songEmitter, "volume_linear", 0, 1)
	
	await fadeTween.finished

	ScoreManager.levelCurrent = currentLevel.levelName.to_lower()
	EntranceManager.transitionRoom(currentLevel.levelStartScene.resource_path, "start", 1)
	return
	
func _displayStats(targetStats:Dictionary) -> void:
	
	var finalText:String = ""
	
	for index in targetStats:
		var value:Variant = targetStats[index]
		
		finalText = finalText + str(index, ": ", value, "\n")
		continue
		
	levelStats.text = finalText
	return

func _swipeTween(fakePortait:TextureRect, realPortait:TextureRect) -> void:
	
	var swipeTween:Tween = get_tree().create_tween()
	
	nudgeLeft.self_modulate.a = 0
	nudgeRight.self_modulate.a = 0
	
	swipeTween.set_parallel(true)
	swipeTween.set_trans(Tween.TRANS_SINE)
	swipeTween.tween_property(fades, "modulate:a", 0, swipeTime/2)
	swipeTween.tween_property(realPortait, "position:x", fakePortait.position.x, swipeTime)
	swipeTween.tween_property(fakePortait, "position:x", 960*-lastDirection, swipeTime)
	
	await swipeTween.finished
	
	var fadeInTween:Tween = get_tree().create_tween()
	fadeInTween.tween_property(fades, "modulate:a", 1, swipeTime/2)
	
	var levelName:String = currentLevel.levelName.to_lower()
	
	nudgeLeft.self_modulate.a = 1
	nudgeRight.self_modulate.a = 1
	
	if ScoreManager.levelBests.has(levelName):
		var currentStats:Dictionary = ScoreManager.levelBests[levelName]
		_displayStats(currentStats)
	else:
		levelStats.text = "No current last"
	
	levelLabel.text = currentLevel.levelName
	
	fakePortait.queue_free()
	canInput = true
	return

func _displayLevel(targetLevel:SelectableLevel) -> void:
	
	canInput = false
	
	var levelIndex:int = levels.find(targetLevel)
	
	nudgeLeft.visible = levelIndex > 0
	nudgeRight.visible = (levelIndex+1) != levels.size()
	
	var clonedTexture:TextureRect = levelPortait.duplicate()
	$CanvasLayer/Control.add_child(clonedTexture)
	clonedTexture.position = levelPortait.position
	
	levelPortait.texture = targetLevel.levelIcon
	levelPortait.position.x = 960*lastDirection
	
	currentLevel = targetLevel
	
	_swipeTween(clonedTexture, levelPortait)
	return

func _ready() -> void:
	CurrentPlayer.reset()
	
	_displayLevel(levels[0])
	return
	
func _levelSelectionInput() -> void:
	
	var currentTime:float = Time.get_unix_time_from_system()
	var timeDiffrence:float = currentTime - selectionPressed
	
	if timeDiffrence < 0.05:
		return
		
	var nextIndex:int = currentIndex
		
	selectionPressed = currentTime
			
	if Input.is_action_just_pressed("player_right"):
		nextIndex += 1
		lastDirection = 1
		
	if Input.is_action_just_pressed("player_left"):
		nextIndex -= 1
		lastDirection = -1
		
	var levelsSize:int = levels.size() - 1
	
	nextIndex = clampi(nextIndex, 0, levelsSize)
	
	if nextIndex == currentIndex:
		return
		
	currentIndex = nextIndex
		
	var targetLevel:SelectableLevel = levels[currentIndex]
	
	_displayLevel(targetLevel)
		
	return
	
func _input(_event: InputEvent) -> void:
	
	if not(canInput):
		return
	
	if _event is InputEventMouseMotion:
		return
		
	if _event is InputEventMouseButton:
		return
		
	if Input.is_action_just_pressed("level_enter"):
		_enterLevel()
		return
		
	_levelSelectionInput()
	
	return
