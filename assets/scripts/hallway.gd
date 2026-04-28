class_name Hallway extends Node2D

@export var hallwayArea:Area2D
@export_file("*.tscn") var targetScene:String
@export var targetEntrance:String


func _bodyEntered(body:Node) -> void:
	
	if body != CurrentPlayer:
		return
		
	EntranceManager.currentEntrance = targetEntrance
	
	var roomTransition:RoomTransition = RoomTransition.new()
	roomTransition.targetScene = targetScene
	
	EntranceManager.add_child(roomTransition)
		
	return
	
func _ready() -> void:
	
	hallwayArea.body_entered.connect(_bodyEntered)
	
	return
