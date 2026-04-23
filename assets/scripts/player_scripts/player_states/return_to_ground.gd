extends PlayerState

var goal:Vector2

func stateEnter(_enterMessage:String) -> void:
	goal = player.lastGroundedPosition - Vector2(0, 32)
	player.runPhysics = false
	animator.animationPlay("grabbed", 0.5)
	return
	
func stateExit(_exitMessage:String) -> void:
	return
	
func stateProcess(_delta:float) -> void:
	
	player.position = player.position.move_toward(goal, 300 * _delta)
	
	var positionDiffrence:Vector2 = goal - player.position
	
	#print(positionDiffrence.length())
	
	if positionDiffrence.length() > 5:
		return
		
	stateManager.switchState("jump")
	player.runPhysics = true
	player.fallzoneManager.fallen = false
	return
