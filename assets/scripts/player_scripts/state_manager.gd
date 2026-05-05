class_name StateManager extends Node

@export var _parentPlayer:Player
@export var _initalState:PlayerState

var _allStates:Dictionary[String, PlayerState] = {}

var currentState:PlayerState

func _registerState(targetState:PlayerState) -> void:
	
	var stateName:String = targetState.name.to_lower()
	targetState.stateManager = self
	targetState.player = _parentPlayer
	targetState.animator = _parentPlayer.animationManager
	
	_allStates[stateName] = targetState
	
	return
	
func switchState(targetState:String, targetEnterMessage:String = "", targetExitMessage:String = "") -> void:
	targetState = targetState.to_lower()
	
	if !(_allStates.has(targetState)):
		push_error(targetState, " is not a valid state!")
		return
		
	var nextState:PlayerState = _allStates[targetState]
	
	if currentState:
		currentState.stateExit(targetExitMessage)
		
	nextState.stateEnter(targetEnterMessage)
	currentState = nextState
	
	return
	
func _ready() -> void:
	
	var allChildren:Array[Node] = get_children()
	
	for child in allChildren:
		
		if not(child is PlayerState):
			continue
		
		_registerState(child)
		
		continue
		
	switchState(_initalState.name)
	
	Console.add_command("player_set_state", switchState, ["String", "String", "String"], 1)
	return
	
func _physics_process(delta: float) -> void:
	 
	if !currentState:
		return
		
	currentState.stateProcess(delta)
	return
