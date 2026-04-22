class_name PlayerCamera extends Camera2D

@export var cameraOffset:Vector2

func _ready() -> void:
	return

func _process(_delta: float) -> void:
	
	if !CurrentPlayer:
		return
		
	position = CurrentPlayer.position + cameraOffset
	
	return
