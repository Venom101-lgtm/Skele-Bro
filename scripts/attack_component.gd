extends Node2D
class_name AttackComponent

@export var sprite : AnimatedSprite2D
@export var area_of_effect: Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_of_effect.monitorable = false
	sprite.hide()
	#Effectively turns off the attack hitbox and hides the sprite

##Does the attack, animation name is the name of the attack animation
func do_attack(animation_name : String) -> void:
	area_of_effect.monitorable = true
	sprite.frame = 0
	sprite.show()
	
	sprite.play(animation_name)
	await sprite.animation_finished
	
	area_of_effect.monitorable = false
	sprite.hide()
