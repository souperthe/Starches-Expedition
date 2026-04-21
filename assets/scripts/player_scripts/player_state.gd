@abstract
class_name PlayerState extends Node

var player:Player
var stateManager:StateManager
var animator:AnimationManager

@abstract
func stateEnter(enterMessage:String) -> void

@abstract
func stateExit(exitMessage:String) -> void

@abstract
func stateProcess(delta:float) -> void
