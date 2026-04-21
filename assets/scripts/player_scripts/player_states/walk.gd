extends PlayerState

var walkAcceleration:float = 950
var currentAcceleration:float = 0
var walkSpeed:float = 93.75*4
var currentAnimationSpeed:float = 0.4
var slopeAngle:float = 0
var slopeInfuence:float = 2

func stateEnter(_enterMessage:String) -> void:
	animator.animationPlay("move", 0.25)
	return
	
func stateExit(_exitMessage:String) -> void:
	return
	
func stateProcess(delta:float) -> void:
	
	player.coyoteTime = player.coyoteTimeMax
	
	if player.controlDirection.x == 0:
		stateManager.switchState("idle")
		return
	else:
		player.sprite.scale.x = player.controlDirection.x
		
	if Input.is_action_just_pressed("player_jump"):
		stateManager.switchState("jump", "jumping")
		return
		
	if !(player.is_on_floor()):
		stateManager.switchState("jump")
		return
		
	var targetAnimationSpeed:float = 0.5
	var targetSpeed:float = player.controlDirection.x * (walkSpeed*1.2)
	player.lastSpeed = (walkSpeed*1.2)
	currentAcceleration = walkAcceleration
	
	var floorNormal:Vector2 = player.get_floor_normal()
	slopeAngle = floorNormal.x * sign(targetSpeed)
	
	var slopeMultiplier: float = 1.0 + (slopeAngle * slopeInfuence)
	slopeMultiplier = clampf(slopeMultiplier, 0.4, 1.6)
	
	
	if (!Input.is_action_pressed("player_run")):
		targetSpeed = player.controlDirection.x * (walkSpeed/2)
		player.lastSpeed = (walkSpeed/1.5)
		currentAcceleration = walkAcceleration
		targetAnimationSpeed = 0.4
		
	currentAnimationSpeed = lerpf(currentAnimationSpeed, targetAnimationSpeed, 12 * delta)
	
	var speedScale:float = abs(player.velocity.x) / walkSpeed
	speedScale = speedScale * currentAnimationSpeed
	
	speedScale = clampf(speedScale, 0.15, 0.9)
	
	var effectiveTarget:float = targetSpeed * slopeMultiplier
	var effectiveAccel:float  = currentAcceleration * slopeMultiplier
	
	var facingLeft:bool = player.controlDirection.x < 0.0
	var isSkidding:bool = player.velocity.x < 0.0 != facingLeft
	
	if isSkidding:
		animator.animationPlay("skid", 0.3)
		effectiveAccel = effectiveAccel * 2
	else:
		animator.animationPlay("move", speedScale)
		
	player.velocity.x = move_toward(player.velocity.x, effectiveTarget, effectiveAccel * delta)

	return
