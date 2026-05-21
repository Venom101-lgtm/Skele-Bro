extends PlayerState

@export var speed : float


func enter():
	currently_moving = true
	sprite.play("Run")

func state_process(_state_delta: float) -> void:
	determine_direction()
	flip_character_input()
	if Input.get_axis("MoveLeft","MoveRight") == 0:
	#So long as we are not moving left or right
		flip_character_mouse()
		#If the player is moving ONLY up or down, prefer to look at mouse
		
	if has_movement_changed():
		transition.emit(self,"Moving")
	
	if is_attacking():
		transition.emit(self,"Attacking")

func state_physics_process(_state_delta: float) -> void:
	player.velocity = player.velocity.lerp(speed * direction.normalized(),friction)
	#Use friction to build up speed
	
