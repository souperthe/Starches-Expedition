class_name Player extends CharacterBody2D

var runPhysics:bool = true
var wishDirection:Vector2
var controlDirection:Vector2
var walkSpeed:float = 93.75*4
var maxHealth:int = 3
var health:int = 3

var gravityScale:float = 1887.5
var lastSpeed:float = 0
var coyoteTime:float = 0
var coyoteTimeMax:float = 8
var lastGroundedPosition:Vector2
var lastAirbornePosition:Vector2


@export var animationManager:AnimationManager
@export var fallzoneManager:FallzoneManager
@export var stateManager:StateManager
@export var soundManager:SoundManager
@export var sprite:AnimatedSprite2D

func _process(_delta: float) -> void:
	wishDirection = Input.get_vector("player_left", "player_right", "player_down", "player_up")
	controlDirection.x = floorf(Input.get_axis("player_left", "player_right"))
	controlDirection.y = floorf(Input.get_axis("player_down", "player_up"))
	
	if is_on_floor():
		lastGroundedPosition = position
	else:
		lastAirbornePosition = position
		
	return

func _physics_process(_delta: float) -> void:
	
	if !runPhysics:
		return
		
	move_and_slide()
	return
