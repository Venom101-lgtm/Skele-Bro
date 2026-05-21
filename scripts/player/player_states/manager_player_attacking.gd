extends PlayerState

func state_process(_state_delta: float) -> void:
	transition.emit(self,"Slash")
