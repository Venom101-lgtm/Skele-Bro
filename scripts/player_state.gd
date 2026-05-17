extends State
class_name PlayerState
##States for the player, holds re-used code

@export var player : CharacterBody2D
#This is here so states can access the player
@export var sprite : AnimatedSprite2D
#This is here so the states can acces the sprite/animations
@export var friction := 0.4
#How much the player slides when stop moving, used in lerp

var direction : Vector2
#Direction of player

##Finds the direction of the player based on keyboard input
func determine_direction() -> void:
	direction = Input.get_vector("MoveLeft","MoveRight","MoveUp","MoveDown")
	
##Flips the character to face towards the mouse
func flip_character_mouse() -> void:
	if player.get_global_mouse_position().x < player.global_position.x:
	#If the mouse x coordinate is less than (to the left) of the player flip the sprite to the left
		sprite.flip_h = true
	else:
	#Else the mouse is to the right flip player to the right
		sprite.flip_h = false

##Flips the character to face the way they're moving
func flip_character_input() -> void:
	if player.velocity.x < 0:
		sprite.flip_h = true
	else: if player.velocity.x > 0:
	#Additional if statement prevents flipping when crashing into walls while still running
		sprite.flip_h = false

##Finds where the mouse is relative to the player returns a normalized vector
func determine_mouse_direction() -> Vector2:
	var mouse_position = player.get_global_mouse_position() - (player.global_position + Vector2(0,-8))
	#Accounts for offset that the player has
	
	return mouse_position.normalized()
	
##Returns true if there is input to move
func is_moving_input() -> bool:
	if Input.get_vector("MoveLeft","MoveRight","MoveUp","MoveDown") != Vector2(0,0):
		return true
	else:
		return false
