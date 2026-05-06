class_name ClassPlayerManager extends Node2D

var players:Array[Player] = []
var playerCount:int = 1

var playerScene:PackedScene = load("res://assets/objects/player.tscn")

func _createPlayer(playerIndex:int) -> void:
	
	var playerInstance:Player = playerScene.instantiate()
	playerInstance.playerIndex = playerIndex
	
	add_child(playerInstance)
	return

func _createPlayers() -> void:
	
	for playerIndex in range(playerCount):
		_createPlayer(playerIndex)
		continue
	
	return
