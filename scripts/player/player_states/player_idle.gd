extends PlayerState

func enter():
	currently_moving = false
	sprite.play("Idle")
	
func state_process(_state_delta: float) -> void:
	flip_character_mouse()
	#Player looks at mouse while idling
	
	if has_movement_changed():
		transition.emit(self,"Moving")
	
	if is_attacking():
		transition.emit(self,"Attacking")

func state_physics_process(_state_delta: float) -> void:
	player.velocity = player.velocity.lerp(Vector2(0,0),friction)
	#Ensures we are not moving using friction
