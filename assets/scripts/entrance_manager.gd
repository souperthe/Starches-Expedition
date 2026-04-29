class_name ClassEntranceManager extends Node

var currentEntrance:String = "A"

func transitionRoom(targetScene:String, targetEntrance:String) -> void:
	
	EntranceManager.currentEntrance = targetEntrance
	
	var roomTransition:RoomTransition = RoomTransition.new()
	roomTransition.targetScene = targetScene
	
	EntranceManager.add_child(roomTransition)
	return
