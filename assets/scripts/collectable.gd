class_name Collectable extends Node2D

@export var value:int = 5
@export var animator:AnimatedSprite2D
@export var collectionArea:Area2D
@export var scoreVisual:PackedScene
@export var coinType:String = "coin"

var _visualColors:Dictionary[bool, Color] = {
	true: Color.RED,
	false: Color.GREEN
}

func _createScoreVisual(targetValue:int) -> void:
	
	var newVisual:ScoreVisual = scoreVisual.instantiate()
	var isNegative:bool = targetValue < 0
	var visualColor:Color = _visualColors[isNegative]
	
	var additionSign:String = "+"
	
	if isNegative:
		additionSign = "-"
	
	newVisual.position = animator.global_position
	newVisual.modulate = visualColor
	newVisual.label.text = additionSign + str(targetValue)
	
	CommonSignals.createCoinVisual.emit(coinType, animator, ScoreManager.currentScore)
	
	get_tree().current_scene.add_child(newVisual)
	
	newVisual.playTween()
	
	
	return

func _bodyEntered(node:Node) -> void:
	
	if node != CurrentPlayer:
		return
		
	ScoreManager.currentScore += value
	ScoreManager.coinCollected.play()
	_createScoreVisual(value)
	queue_free()
	return

func _ready() -> void:
	animator.play("default")
	collectionArea.body_entered.connect(_bodyEntered)
	return
