@abstract
extends State
class_name PlayerState
##States for the player, holds re-used code

@export var player : CharacterBody2D
#This is here so states can access the player

@onready var hitbox_component: HitboxComponent = %HitboxComponent

@onready var attack_animations: AnimationPlayer = %AttackAnimations
@onready var movement_animations: AnimationPlayer = %MovementAnimations
@onready var sprite: Sprite2D = %SkeleBroSprite
#This is here so the states can acces the sprite/animations

@export var friction := 0.4
#How much the player slides when stop moving, used in lerp

var direction : Vector2
#Direction of player
var currently_moving := false
#Tracks if the player is currently moving or not

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
	if Input.get_axis("MoveLeft","MoveRight") < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

##Finds where the mouse is relative to the player returns a normalized vector
func determine_mouse_direction() -> Vector2:
	var mouse_position = player.get_global_mouse_position() - (player.global_position + Vector2(0,-8))
	#Accounts for offset that the player has
	
	return mouse_position.normalized()
	
##Returns true if there has been a change in the player's movement, used for moving manager state
func has_movement_changed() -> bool:
	var movement : bool
	
	#Checks if character is moving or not
	if Input.get_vector("MoveLeft","MoveRight","MoveUp","MoveDown") != Vector2(0,0):
		movement = true
	else:
		movement = false
	
	#If current motion matches new motion return false
	if currently_moving == movement:
		return false
	else:
	#Difference in motion update currently moving and return true
		currently_moving = movement
		return true

##Returns true if the player is attacking, used for attacking manager state
func is_attacking() -> bool:
	if Input.is_action_just_pressed("Slash"):
		return true
	else:
		return false
