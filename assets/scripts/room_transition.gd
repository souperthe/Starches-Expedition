class_name RoomTransition extends CanvasLayer

var fadeRect:ColorRect
var fadeTime:float = 0.2
var targetScene:String

func _rectOut() -> void:
	
	var outTween:Tween = get_tree().create_tween()
	outTween.tween_property(fadeRect, "modulate:a", 0, fadeTime)
	
	get_tree().change_scene_to_file(targetScene)
	
	await CommonSignals.sentToEntrance
	
	CurrentPlayer.runPhysics = true
	return

func _rectIn() -> void:
	
	var inTween:Tween = get_tree().create_tween()
	inTween.tween_property(fadeRect, "modulate:a", 1, fadeTime)
	
	inTween.finished.connect(_rectOut)
	
	return

func _ready() -> void:
	fadeRect = ColorRect.new()
	fadeRect.set_anchors_preset(Control.PRESET_FULL_RECT)
	fadeRect.color = Color.BLACK
	fadeRect.modulate.a = 0
	add_child(fadeRect)
	
	CurrentPlayer.runPhysics = false
	
	_rectIn()
	return
