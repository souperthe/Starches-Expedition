extends Control

@export var goto:Control

func _tweenFinished(visual:Node2D, currentScore:int) -> void:
	visual.queue_free()
	CommonSignals.updateCoins.emit(currentScore)
	return

func _tweenTo(visual:Node2D, visualGoto:Vector2, currentScore:int) -> void:
	var currentSize:Vector2 = visual.scale
	var glideTime:float = 0.7
	var glideTween:Tween = get_tree().create_tween()
	glideTween.set_parallel(true)
	glideTween.tween_property(visual, "position", visualGoto, glideTime)
	glideTween.tween_property(visual, "scale", currentSize/1.7, glideTime)
	
	var finishedCallable:Callable = func():
		_tweenFinished(visual, currentScore)
		return
	
	glideTween.finished.connect(finishedCallable)
	return

func _createVisual(_visualType:String, visualAnimator:AnimatedSprite2D, currentScore:int) -> void:
	
	var screenPosition:Vector2 = visualAnimator.get_global_transform_with_canvas().get_origin()
	var clonedSprite:AnimatedSprite2D = visualAnimator.duplicate()
	
	clonedSprite.position = screenPosition
	clonedSprite.scale *= 2
	
	
	add_child(clonedSprite)
	_tweenTo(clonedSprite, goto.global_position, currentScore)
	return

func _ready() -> void:
	CommonSignals.createCoinVisual.connect(_createVisual)
	return
