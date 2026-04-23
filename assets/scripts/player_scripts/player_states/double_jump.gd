extends PlayerState

var walkAcceleration:float = 950.0*1.5

func stateEnter(_enterMessage:String) -> void:
	
	if player.controlDirection.x != 0:
		player.sprite.scale.x = player.controlDirection.x
		player.velocity.x = player.controlDirection.x * player.walkSpeed
	
	animator.animationPlay("doublejump", 0.3)
	player.velocity.y = -300.0 * 1.5
	
	return
	
func stateExit(_exitMessage:String) -> void:
	return
	
func stateProcess(delta:float) -> void:
	
	player.velocity.y += player.gravityScale * delta
	var targetSpeed:float = player.controlDirection.x * (player.lastSpeed/2)

	if player.controlDirection.x != 0:
		player.sprite.scale.x = player.controlDirection.x
		
	player.velocity.x = move_toward(player.velocity.x, targetSpeed, walkAcceleration * delta)
	
	if Input.is_action_just_pressed("player_attack"):
		stateManager.switchState("dive")
		return
	
	if player.is_on_floor():
		stateManager.switchState("idle", "landing")
		return
		
	return
