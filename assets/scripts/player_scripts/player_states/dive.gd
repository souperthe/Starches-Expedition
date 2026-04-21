extends PlayerState


func stateEnter(_enterMessage:String) -> void:
	
	if player.controlDirection.x != 0:
		player.sprite.scale.x = player.controlDirection.x
	
	animator.animationPlay("dive", 0.3)
	player.velocity.y = -240.0
	player.velocity.x = player.controlDirection.x * 600
	return
	
func stateExit(_exitMessage:String) -> void:
	return
	
func stateProcess(delta:float) -> void:

	player.velocity.y += player.gravityScale * delta

		
	if player.is_on_floor():
		stateManager.switchState("idle", "landing")
		return
		
	return
