@tool
class_name CameraLimiter extends Container

func _setupLine(desiredLine:Line2D) -> void:
	desiredLine.clear_points()
	
	var intSize:Vector2i = Vector2i(int(size.x), int(size.y))
	
	desiredLine.add_point(Vector2i.ZERO)
	desiredLine.add_point(Vector2i(intSize.x, 0))
	desiredLine.add_point(Vector2i(intSize.x, intSize.y))
	desiredLine.add_point(Vector2i(0, intSize.y))
	desiredLine.add_point(Vector2i.ZERO)
	return

func _getLimits() -> String:
	var limitTop:int = int(position.y)
	var limitLeft:int = int(position.x)
	var limitBottom:int = int(position.y + size.y)
	var limitRight:int = int(position.x + size.x)
	
	var limits:Array[int] = []
	var finalString:String = "("
	
	limits.append(limitTop)
	limits.append(limitLeft)
	limits.append(limitBottom)
	limits.append(limitRight)
	
	for limit in limits:
		var limitIndex:int = limits.find(limit)
		
		if limitIndex == limits.size()-1:
			finalString += str(limit)
		else:
			finalString += str(limit) + ", "
		continue
	
	finalString += ")"
	
	return finalString


func _editorReady() -> void:
	z_index = 20
	
	
	var newLabel:Label = Label.new()
	var newLine:Line2D = Line2D.new()
	
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	newLabel.text = _getLimits()
	newLabel.z_index = 2
	
	newLine.default_color = Color.RED
	newLine.begin_cap_mode = Line2D.LINE_CAP_ROUND
	newLine.end_cap_mode = Line2D.LINE_CAP_ROUND
	
	_setupLine(newLine)
	
	resized.connect(func():
		newLabel.text = _getLimits()
		_setupLine(newLine)
		)
	
	add_child(newLabel)
	add_child(newLine)
	return
	
func _normalReady() -> void:
	CurrentCamera.limit_bottom = int(global_position.y + size.y)
	CurrentCamera.limit_top = int(global_position.y)
	CurrentCamera.limit_left = int(global_position.x)
	CurrentCamera.limit_right = int(global_position.x + size.x)
	
	#if SceneManager.mirrorScenes:
		#CurrentCamera.limit_right = int(global_position.x)
		#CurrentCamera.limit_left = int(global_position.x - size.x)
	
	queue_free()
	return

func _ready() -> void:
	
	if Engine.is_editor_hint():
		_editorReady()
	else:
		_normalReady()
	
	
	return
