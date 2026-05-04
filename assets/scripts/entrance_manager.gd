class_name ClassEntranceManager extends Node

var currentEntrance:String = "A"

func _ready() -> void:
	Console.add_command("room_change", transitionRoom, ["String", "String", "Float"], 2)
	Console.add_command("room_change_file", _changeSceneFile, ["String"], 1)
	return
	
func _onFileSelect(scenePath:String) -> void:
	
	var loadedScene:PackedScene = load(scenePath)
	
	get_tree().change_scene_to_packed(loadedScene)
	return
	
func _changeSceneFile(desiredEntrance:String) -> void:
	
	currentEntrance = desiredEntrance
	
	var fileSelect:FileDialog = FileDialog.new()
	fileSelect.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	fileSelect.use_native_dialog = true
	fileSelect.access = FileDialog.ACCESS_FILESYSTEM
	add_child(fileSelect)
	fileSelect.popup()
	
	fileSelect.file_selected.connect(_onFileSelect)
	
	return

func transitionRoom(targetScene:String, targetEntrance:String, fadeTime:float=0.2) -> void:
	
	EntranceManager.currentEntrance = targetEntrance
	
	var roomTransition:RoomTransition = RoomTransition.new()
	roomTransition.fadeTime = fadeTime
	roomTransition.targetScene = targetScene
	
	print(targetScene)
	print(targetEntrance)
	
	EntranceManager.add_child(roomTransition)
	return
