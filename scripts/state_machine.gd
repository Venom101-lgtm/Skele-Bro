extends Node
class_name StateMachine

@export var initial_state : State
#Specified state to start with

var current_state : State
var states: Dictionary
#Defines our current state and creates a dictionary to hold all possible states

func add_to_states(children_to_add: Array) -> void:
	for child_to_add in children_to_add:
		if child_to_add is State:
			states[child_to_add.name.to_lower()] = child_to_add #Adds state to state machine
			child_to_add.transition.connect(on_child_transition)
			#Connects the function for switching state to the signal for every state

func _ready() -> void:
	add_to_states(get_children())
	#Adds the manager states
	
	for child in get_children():
		add_to_states(child.get_children())
		#Adds the child states that the manager states manage
	
	#All children of state machine are all of the possible states
		
	if initial_state:
	#Enters an initial state if one is defined
		initial_state.enter()
		current_state = initial_state
	
func _process(delta: float) -> void:
	if current_state:
	#If the current state exists does process like normal
		current_state.state_process(delta)
		
func _physics_process(delta: float) -> void:
	if current_state:
	#If the current state exists does physics process like normal
		current_state.state_physics_process(delta)
		
##Goes from one state to another
##input_state is the state you start on
##new_state_name is the name of the state you want to transition to
func on_child_transition(input_state,new_state_name) -> void:
	if input_state != current_state:
	#If you try to transition into the state you're already in return nothing
		return
	
	var new_state = states.get(new_state_name.to_lower())
	#Instance of the state with the name you want to transition to
	
	if !new_state:
	#Returns nothing if that state doesn't exist
		return
	if current_state:
	#Exits current state if that state exists
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
	#Enters new state and sets it as current state
