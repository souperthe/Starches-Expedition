extends PlayerState

var walkAcceleration:float = 950.0*1.5
var walkSpeed:float = 93.75*4
var jumpPower:Array[float] = [-240.0, -240.0, -300.0]
var speedThreshold:float = 0
var jumpLetGo:bool = false

func stateEnter(_enterMessage:String) -> void:
	
	jumpLetGo = true
	animator.animationPlay("jump", 9000)
	
	if _enterMessage != "jumping":
		return
		
	player.soundManager.playSound("jump")
		
	player.coyoteTime = player.coyoteTimeMax
		
	jumpLetGo = false
	animator.animationPlay("idle", 0.3)
	animator.animationPlay("jump", 0.4)
		
	var speed:float= abs(player.velocity.x)
	speedThreshold = jumpPower.size()

	for i in jumpPower.size():
		if speed < jumpPower[i]:
			speedThreshold = i
			break
			
	var jumpIndex:int = int(speedThreshold)
	
	jumpIndex = clampi(jumpIndex, 0, 2)
	
	player.velocity.y = jumpPower[jumpIndex] * 2
	player.coyoteTime = -500
	return
	
func stateExit(_exitMessage:String) -> void:
	return
	
func stateProcess(delta:float) -> void:
		
	var targetSpeed:float = player.controlDirection.x * player.lastSpeed
	player.velocity.y += player.gravityScale * delta
	
	player.coyoteTime -= 30 * delta
	
	if player.coyoteTime > 0 and Input.is_action_just_pressed(player.inputJump):
		stateManager.switchState("jump", "jumping")
		player.coyoteTime = -500
		return
		
	if player.controlDirection.x != 0:
		player.sprite.scale.x = player.controlDirection.x
		
	player.velocity.x = move_toward(player.velocity.x, targetSpeed, walkAcceleration * delta)
		
	if Input.is_action_just_pressed(player.inputAttack):
		stateManager.switchState("dive")
		return

	if not(Input.is_action_pressed(player.inputJump)) and player.velocity.y < 0:
		player.velocity.y *= (0.85*60) * delta
		
	if player.is_on_floor():
		stateManager.switchState("idle", "landing")
		return
		
	return
