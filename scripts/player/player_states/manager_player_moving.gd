extends PlayerState

func state_process(_state_delta: float) -> void:
	if Input.get_vector("MoveLeft","MoveRight","MoveUp","MoveDown") != Vector2(0,0):
	#If there's input, run
		transition.emit(self,"Run")
	else:
	#Else no input, idle
		transition.emit(self,"Idle")
