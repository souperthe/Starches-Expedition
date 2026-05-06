class_name RoomTransition extends CanvasLayer

var fadeRect:ColorRect
var fadeTime:float = 0.2
var fakeWait:float = 0.1
var targetScene:String

func setPlayersPhysics(enabled:bool) -> void:
	
	for player in PlayerManager.players:
		player.runPhysics = enabled
		continue
		
	return

func _rectOut() -> void:
	
	await get_tree().create_timer(fakeWait).timeout
	
	get_tree().change_scene_to_file(targetScene)
	
	await CommonSignals.sentToEntrance
	
	var outTween:Tween = get_tree().create_tween()
	outTween.tween_property(fadeRect, "modulate:a", 0, fadeTime)
	
	setPlayersPhysics(true)
	return

func _rectIn() -> void:
	
	var inTween:Tween = get_tree().create_tween()
	inTween.tween_property(fadeRect, "modulate:a", 1, fadeTime)
	
	inTween.finished.connect(_rectOut)
	
	return

func _ready() -> void:
	layer = 10
	fadeRect = ColorRect.new()
	fadeRect.set_anchors_preset(Control.PRESET_FULL_RECT)
	fadeRect.color = Color.BLACK
	fadeRect.modulate.a = 0
	add_child(fadeRect)
	
	setPlayersPhysics(false)
	
	_rectIn()
	return
