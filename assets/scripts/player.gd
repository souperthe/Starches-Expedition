class_name Player extends CharacterBody2D

var runPhysics:bool = true
var wishDirection:Vector2
var controlDirection:Vector2

var gravityScale:float = 1687.5
var lastSpeed:float = 0
var coyoteTime:float = 0
var coyoteTimeMax:float = 5


@export var animationManager:AnimationManager
@export var soundManager:SoundManager
@export var sprite:AnimatedSprite2D

func _process(_delta: float) -> void:
	wishDirection = Input.get_vector("player_left", "player_right", "player_down", "player_up")
	controlDirection.x = Input.get_axis("player_left", "player_right")
	controlDirection.y = Input.get_axis("player_down", "player_up")
	return

func _physics_process(_delta: float) -> void:
	
	if !runPhysics:
		return
		
	move_and_slide()
	return
