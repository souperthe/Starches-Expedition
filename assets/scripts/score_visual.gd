class_name ScoreVisual extends Node2D

@export var label:Label


func playTween() -> void:
	
	var fadeTime:float = 0.7
	var fadeTween:Tween = get_tree().create_tween()
	
	fadeTween.set_parallel(true)
	fadeTween.tween_property(self, "modulate:a8", 0, fadeTime)
	fadeTween.tween_property(label, "position:y", -46.5, fadeTime)
	
	return
