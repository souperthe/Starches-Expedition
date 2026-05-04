class_name MusicPlayer extends Node

@export var targetSong:AudioStream
@export var targetSeek:bool = false

func _ready() -> void:
	
	if targetSong == null:
		return
	
	if MusicManager.songCurrent == targetSong.resource_path:
		return
		
	print("play")
		
	MusicManager.songPlayPacked(targetSong, targetSeek)
	queue_free()
	return
