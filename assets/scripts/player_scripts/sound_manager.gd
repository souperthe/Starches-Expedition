class_name SoundManager extends Node

@export var soundHolder:Node2D

var _sounds:Dictionary[String, AudioStreamPlayer2D]

func playSound(soundName:String, soundPitch:float=1) -> void:
	soundName = soundName.to_lower()
	
	if !(_sounds.has(soundName)):
		return
		
	var targetSound:AudioStreamPlayer2D = _sounds[soundName]
	
	targetSound.play()
	targetSound.pitch_scale = soundPitch
	return
	
func stopSound(soundName:String) -> void:
	soundName = soundName.to_lower()
	
	if !(_sounds.has(soundName)):
		return
		
	var targetSound:AudioStreamPlayer2D = _sounds[soundName]
	
	targetSound.play()
	return

func _ready() -> void:
	
	var children:Array[Node] = soundHolder.get_children()
	
	for child in children:
		
		if not(child is AudioStreamPlayer2D):
			continue
			
		var soundName:String = child.name.to_lower()
		
		_sounds[soundName] = child
		
		continue
	
	
	return
