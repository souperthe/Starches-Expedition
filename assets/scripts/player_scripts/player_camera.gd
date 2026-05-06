class_name PlayerCamera extends Camera2D

@export var cameraOffset:Vector2

var shakeAmount:float = 0
var shakeDecay:float = 2
var decayTo:float = 0
var defaultZoom:float = 2.0


func cameraShake(amount:float = 2, decay:float = 3) -> void:
	shakeAmount = amount
	shakeDecay = decay
	return

func _shakeProcess(delta:float) -> void:
	
	shakeAmount = lerpf(shakeAmount, decayTo, shakeDecay * delta)
	
	offset.x = randf_range(-shakeAmount,shakeAmount)
	offset.y = randf_range(-shakeAmount,shakeAmount)
	rotation_degrees = randf_range(-shakeAmount,shakeAmount)/2
	return
	
func _getPlayerCenter() -> Vector2:
	var playerPositions:Array[Vector2] = PlayerManager.getPlayerPositions()
	
	if playerPositions.is_empty():
		return Vector2.ZERO
		
	var positionSum:Vector2 = Vector2.ZERO
	
	for pos in playerPositions:
		positionSum += pos
		continue
	
	return positionSum / playerPositions.size()

func _ready() -> void:
	return

func _process(_delta: float) -> void:
		
	position = _getPlayerCenter() + cameraOffset
	_shakeProcess(_delta)
	
	return
