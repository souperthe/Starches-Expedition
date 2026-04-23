@tool
class_name RoomEntrance extends Node2D

@export var targetEntrance:String:
	set(newValue):
		targetEntrance = newValue
		if !Engine.is_editor_hint():
			return
			
		currentLabel.text = newValue
		return

var currentLabel:Label
var playerSprite:CompressedTexture2D = load("res://assets/images/characters/starch/starch_idle.swf/frames/1.svg")


func _editorReady() -> void:
	
	var referenceSprite:Sprite2D = Sprite2D.new()
	referenceSprite.texture = playerSprite
	referenceSprite.position = Vector2(0,-30.4)
	referenceSprite.scale = Vector2(0.15, 0.15)
	referenceSprite.modulate = Color.from_rgba8(255, 0, 0, 105)
	
	var referenceLabel:Label = Label.new()
	referenceLabel.size = Vector2(40, 23)
	referenceLabel.position = Vector2(-20, -11.5)
	referenceLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	referenceLabel.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	referenceLabel.text = targetEntrance
	
	currentLabel = referenceLabel
	
	add_child(referenceSprite)
	add_child(referenceLabel)
	return
	
func _ready() -> void:
	
	if Engine.is_editor_hint():
		_editorReady()
		return
		
	var currentEntrance:String = EntranceManager.currentEntrance.to_lower()
	var desiredEntrance:String = targetEntrance.to_lower()
	
	if desiredEntrance != currentEntrance:
		return
		
	CurrentPlayer.position = position 
	CommonSignals.sentToEntrance.emit(desiredEntrance)
	
	return
