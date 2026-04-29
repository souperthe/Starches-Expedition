class_name ClassEntranceManager extends Node

var currentEntrance:String = "A"

func transitionRoom(targetScene:String, targetEntrance:String, fadeTime:float=0.2) -> void:
	
	EntranceManager.currentEntrance = targetEntrance
	
	var roomTransition:RoomTransition = RoomTransition.new()
	roomTransition.fadeTime = fadeTime
	roomTransition.targetScene = targetScene
	
	EntranceManager.add_child(roomTransition)
	return
