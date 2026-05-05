class_name ClassMusicManager extends Node

@export var songEmitter:AudioStreamPlayer

var songCurrent:String = ""
var songVolume:float = 0.5
var songStream:AudioStream
var songEndPosition:float

func _ready() -> void:
	songEmitter.volume_linear = songVolume
	return
	
func songPlayPacked(targetStream:AudioStream, targetSeek:bool=false) -> void:
	var songPosition:float = songEmitter.get_playback_position()
	
	songEmitter.stream = targetStream
	songEmitter.play()
	songEmitter.volume_linear = songVolume
	songEmitter.pitch_scale = 1
	
	if targetSeek:
		songEmitter.seek(songPosition)
		
	songCurrent = targetStream.resource_path
	songStream = targetStream
	return
	
func songStop() -> void:
	songEmitter.stop()
	songEmitter.stream = null
	songCurrent = ""
	return

func songPlay(songPath:String, songSeek:bool=false) -> void:
	var songLoaded:AudioStream = load(songPath)
	songPlayPacked(songLoaded, songSeek)
	return
