class_name ClassPlayerManager extends Node2D

var players:Array[Player] = []
var playerCount:int = 2
var playerMain:Player

var playerScene:PackedScene = load("res://assets/objects/player.tscn")

func getPlayerPositions() -> Array[Vector2]:
	
	var playerPositions:Array[Vector2] = []
	
	for player in PlayerManager.players:
		playerPositions.append(player.position)
		continue
	
	return playerPositions

func _createPlayer(playerIndex:int) -> void:
	
	var playerInstance:Player = playerScene.instantiate()
	playerInstance.playerIndex = playerIndex
	
	if playerIndex == 0:
		playerMain = playerInstance
	
	players.insert(playerIndex, playerInstance)
	add_child(playerInstance)
	
	print("PlayerManager -> created player with index: ", playerIndex)
	return

func _createPlayers() -> void:
	
	for playerIndex in range(playerCount):
		_createPlayer(playerIndex)
		continue
	
	return
	
func _ready() -> void:
	_createPlayers()
	return
