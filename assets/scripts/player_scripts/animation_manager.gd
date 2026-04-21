class_name AnimationManager extends Node

@export var _targetAnimator:AnimatedSprite2D
@export var soundManager:SoundManager

var _stepSoundData:Dictionary[String, PackedInt32Array] = {
	move = [2, 8]
}

var _animationNames:Dictionary[String, String] = {}
var animationCurrent:String
var currentFrame:int = 0

func _onFrameChanged() -> void:
	
	if currentFrame == _targetAnimator.frame:
		return
		
	currentFrame = _targetAnimator.frame
	
	if !_stepSoundData.has(animationCurrent):
		return
		
	var stepFrames:PackedInt32Array = _stepSoundData[animationCurrent]
	
	if !stepFrames.has(currentFrame):
		return
		
	#print(currentFrame)
		
	soundManager.playSound("step")
	
	return

func _ready() -> void:
	
	var animatorFrames:SpriteFrames = _targetAnimator.sprite_frames
	var allAnimations:PackedStringArray = animatorFrames.get_animation_names()
	
	for animation in allAnimations:
		var animationLower:String = animation.to_lower()
		_animationNames[animationLower] = animation
		continue
		
	_targetAnimator.frame_changed.connect(_onFrameChanged)
		
	return
	
func animationAdjustSpeed(targetSpeed:float) -> void:
	_targetAnimator.speed_scale = targetSpeed
	return
	
func animationPlay(targetAnimation:String, targetSpeed:float=1) -> void:
	targetAnimation = targetAnimation.to_lower()
	
	if !(_animationNames.has(targetAnimation)):
		push_error(targetAnimation, " is not a valid animation!")
		return
		
	var desiredAnimation:String = _animationNames[targetAnimation]
	
	_targetAnimator.speed_scale = targetSpeed
	_targetAnimator.play(desiredAnimation)
	animationCurrent = desiredAnimation
	return
