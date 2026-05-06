class_name MusicPlayer extends Node

@export var targetSong:AudioStream
@export var targetSeek:bool = false
@export var targetEndPosition:float

func _ready() -> void:
	
	if targetSong == null:
		return
	
	if MusicManager.songCurrent == targetSong.resource_path:
		return
		
	MusicManager.songPlayPacked(targetSong, targetSeek)
	MusicManager.songEndPosition = targetEndPosition
	queue_free()
	return
