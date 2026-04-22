class_name HUDGeneral extends Control

@export var coinLabel:Label
@export var coinIcon:TextureRect

var coinCurentTween:Tween

func _updateCoins(currentScore:int) -> void:
	
	if coinCurentTween:
		coinCurentTween.kill()
	
	coinLabel.text = str(currentScore)
	coinIcon.scale = Vector2(0.25,0.25)
	
	coinCurentTween = get_tree().create_tween()
	coinCurentTween.tween_property(coinIcon, "scale", Vector2(0.15, 0.15), 0.2)
	return
	
func _ready() -> void:
	CommonSignals.updateCoins.connect(_updateCoins)
	return
