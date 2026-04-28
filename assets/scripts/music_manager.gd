class_name ClassMusicManager extends Node

@export var songEmitter:AudioStreamPlayer

var songCurrent:String = ""
var songVolume:float = 0.5

func _ready() -> void:
	songEmitter.volume_linear = songVolume
	return
	
func songPlayPacked(songStream:AudioStream, songSeek:bool=false) -> void:
	var songPath:String = songStream.resource_path
	
	songPlay(songPath, songSeek)
	return
	
func songStop() -> void:
	songEmitter.stop()
	songEmitter.stream = null
	songCurrent = ""
	return

func songPlay(songPath:String, songSeek:bool=false) -> void:
	var songPosition:float = songEmitter.get_playback_position()
	var songLoaded:AudioStream = load(songPath)
	
	songEmitter.stream = songLoaded
	songEmitter.play()
	
	if songSeek:
		songEmitter.seek(songPosition)
		
	songCurrent = songPath
	return
