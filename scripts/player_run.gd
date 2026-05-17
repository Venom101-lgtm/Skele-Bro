extends PlayerState

@export var speed : float


func enter():
	sprite.play("Run")

func state_process(_state_delta: float) -> void:
	determine_direction()
	flip_character_input()
	if Input.get_axis("MoveLeft","MoveRight") == 0:
	#So long as we are not moving left or right
		flip_character_mouse()
		#If the player is moving ONLY up or down, prefer to look at mouse

func state_physics_process(_stateDelta: float) -> void:
	if Input.is_action_just_pressed("Attack"):
		transition.emit(self, "Attack")
	
	if is_moving_input():
	#As long as there is some input we set velocity equal to direction times speed
		player.velocity = player.velocity.lerp(speed * direction.normalized(),friction)
		#Use friction to build up speed
	else:
		transition.emit(self,"Idle")
	
