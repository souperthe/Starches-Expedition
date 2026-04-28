class_name FallzoneManager extends Node

@export var parentPlayer:Player
@export var fallzoneLaugh:AudioStreamPlayer

var fallen:bool = false

func _fallen() -> void:
	parentPlayer.velocity = Vector2.ZERO
	parentPlayer.stateManager.switchState("actor")
	parentPlayer.soundManager.playSound("fallzone")
	CurrentCamera.cameraShake(5, 3)
	
	await get_tree().create_timer(0.5).timeout
	
	fallzoneLaugh.play()
	
	await get_tree().create_timer(0.3).timeout
	
	parentPlayer.stateManager.switchState("returntoground")
	return

func _physics_process(_delta: float) -> void:
	
	var playerPosition:Vector2 = parentPlayer.position
	
	if playerPosition.y < CurrentCamera.limit_bottom * 1.2:
		return
		
	if parentPlayer.stateManager.currentState.name == "Actor":
		return
		
	if fallen:
		return
		
	fallen = true
	
	_fallen()
	
	return
