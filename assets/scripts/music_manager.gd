class_name ClassMusicManager extends Node

@export var songEmitter:AudioStreamPlayer

var songCurrent:String = ""
var songVolume:float = 0.5

func _ready() -> void:
	songEmitter.volume_linear = songVolume
	return
	
func songPlayPacked(songStream:AudioStream, songSeek:bool=false) -> void:
	var songPosition:float = songEmitter.get_playback_position()
	
	songEmitter.stream = songStream
	songEmitter.play()
	songEmitter.volume_linear = songVolume
	songEmitter.pitch_scale = 1
	
	if songSeek:
		songEmitter.seek(songPosition)
		
	songCurrent = songStream.resource_path
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
