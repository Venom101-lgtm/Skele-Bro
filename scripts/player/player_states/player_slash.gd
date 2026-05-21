extends PlayerState

@export var attack_distance : float
@export var modified_speed : float

@onready var attack_component: AttackComponent = %AttackComponent
@onready var attack_animation: AnimatedSprite2D = %AttackAnimation

func enter():
	flip_character_mouse()
	#Flips the character
	
	var mouse = determine_mouse_direction()
	if mouse.x < 0:
		attack_animation.flip_v = true
	else:
		attack_animation.flip_v = false
	
	attack_component.rotation = mouse.angle()
	attack_component.position = attack_distance * mouse + Vector2(0,-8)
	#Accounts for player offset
	#All of this just positions the attack properly
	
	sprite.play("Attack")
	attack_component.do_attack("Swing")
	await attack_animation.animation_finished
	
	transition.emit(self,"Moving")

func state_physics_process(_state_delta: float) -> void:
	determine_direction()
	player.velocity = player.velocity.lerp(modified_speed * direction.normalized(),friction)
	#Changes the players speed with friction
