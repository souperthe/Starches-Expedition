extends Control



@export var coinLabel:Label
@export var coinIcon:TextureRect
@export var coinCollect:AudioStreamPlayer

var coinCurentTween:Tween

func _updateCoins(currentScore:int) -> void:
	
	if coinCurentTween:
		coinCurentTween.kill()
	
	coinLabel.text = str(currentScore)
	
	if currentScore == 0:
		return
		
	coinIcon.scale = Vector2(0.3,0.3)
	
	coinCurentTween = get_tree().create_tween()
	coinCurentTween.tween_property(coinIcon, "scale", Vector2(0.15, 0.15), 0.1)
	coinCollect.play()
	return
	
func _ready() -> void:
	CommonSignals.updateCoins.connect(_updateCoins)
	return
