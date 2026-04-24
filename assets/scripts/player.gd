class_name Player extends CharacterBody2D

var playerIndex:int = 0
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
@export var hudLayer:CanvasLayer
@export var sprite:AnimatedSprite2D


var inputJump:String = "player_jump"
var inputAttack:String = "player_attack"
var inputSprint:String = "player_run"
var inputLeft:String = "player_left"
var inputRight:String = "player_right"
var inputUp:String = "player_up"
var inputDown:String = "player_down"

func reset() -> void:
	ScoreManager.currentScore = 0
	CommonSignals.updateCoins.emit(0)
	fallzoneManager.fallen = false
	hudLayer.show()
	$PlayerHUD/Intro/AnimationPlayer.play("RESET")
	return

func _process(_delta: float) -> void:
	wishDirection = Input.get_vector(inputLeft, inputRight, inputDown, inputUp)
	controlDirection.x = floorf(Input.get_axis(inputLeft, inputRight))
	controlDirection.y = floorf(Input.get_axis(inputDown, inputUp))
	
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
