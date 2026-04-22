extends PlayerState

var deacceleration:float = 2500*1.5
var minimumSpeed:float = 4.453125

func stateEnter(_enterMessage:String) -> void:
	
	if _enterMessage == "landing":
		player.soundManager.playSound("step")
	return
	
func stateExit(_exitMessage:String) -> void:
	return
	
func stateProcess(delta:float) -> void:
	
	player.coyoteTime = player.coyoteTimeMax
	
	if player.controlDirection.x != 0:
		stateManager.switchState("walk")
		return
		
	if Input.is_action_just_pressed("player_jump"):
		stateManager.switchState("jump", "jumping")
		return
		
	if !(player.is_on_floor()):
		stateManager.switchState("jump")
		return
		
	if abs(player.velocity.x) < minimumSpeed:
		player.velocity.x = 0.0
		
		if animator.animationCurrent != "idle":
			animator.animationPlay("idle", 0.1)
	else:
		var speedScale:float = abs(player.velocity.x) / player.walkSpeed
		animator.animationAdjustSpeed(speedScale * 0.25)
		player.velocity.x = move_toward(player.velocity.x, 0.0, deacceleration * delta)
		
	return
