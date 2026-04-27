extends Collidable

@export var playerArea:Area2D

var _falling:bool = false
var _fallingVelocity:float = 0
var _shaking:bool = false
var _previousPosition:Vector2

func _process(delta: float) -> void:
	
	if _shaking:
		$Sprite.offset.x = randf_range(-2, 2)
		$Sprite.offset.y = randf_range(-2, 2)
		return
		
	_fallingVelocity += 40 * delta
	position.y += _fallingVelocity
	return
	
func _reset() -> void:
	_fallingVelocity = 0
	position = _previousPosition
	_falling = false
	_shaking = false
	$Sprite.modulate = Color.WHITE
	set_process(false)
	$StaticBody2D/CollisionShape2D.disabled = false
	return

func _bodyEntered(body:Node2D) -> void:
	
	if body != CurrentPlayer:
		return
		
	if CurrentPlayer.fallzoneManager.fallen:
		return
	
	if _falling:
		return
		
	_previousPosition = position
		
	set_process(true)
		
	_falling = true
	$Sprite.modulate = Color.RED
	_shaking = true
	$Shake.play()
	
	await get_tree().create_timer(0.4).timeout
	
	$Shake.stop()
	_shaking = false
	$Fall.play()
	
	$StaticBody2D/CollisionShape2D.disabled = true
	
	await get_tree().create_timer(1).timeout
	
	_reset()
	
	return

func _ready() -> void:
	set_process(false)
	playerArea.body_entered.connect(_bodyEntered)
	return
