class_name Hallway extends Node2D

@export var hallwayArea:Area2D
@export_file("*.tscn") var targetScene:String
@export var targetEntrance:String


func _bodyEntered(body:Node) -> void:
	
	if not(body is Player):
		return
		
	EntranceManager.transitionRoom(targetScene, targetEntrance)
		
	return
	
func _ready() -> void:
	
	hallwayArea.body_entered.connect(_bodyEntered)
	
	return
