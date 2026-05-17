extends PlayerState

func enter():
	sprite.play("Idle")
	
func state_process(_stateDelta: float) -> void:
	flip_character_mouse()
	#Player looks at mouse while idling
	
	if Input.is_action_just_pressed("Attack"):
		transition.emit(self,"Attack")
	
	if is_moving_input():
	#If input is pressed switch to run state
		transition.emit(self,"Run")

func state_physics_process(_state_delta: float) -> void:
	player.velocity = player.velocity.lerp(Vector2(0,0),friction)
	#Ensures we are not moving using friction
