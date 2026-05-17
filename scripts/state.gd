extends Node
class_name State
##A state that the player or an entity can be in

##Signals for a transition between states
signal transition

##Enters a new state and does something
func enter() -> void:
	pass
	
##A function to do something and exit current state
func exit() -> void:
	pass
	
##Different function so all states don't run at same time
func state_process(_state_delta: float) -> void:
	pass
	
##Different function so all states don't run at the same time
func state_physics_process(_state_delta: float) -> void:
	pass
	
