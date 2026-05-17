extends StaticBody2D

@export var is_locked_door : bool = true
@export var door_type : global.AreaNames
@export var fog_of_war : Node2D

@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var interactable_area: CollisionShape2D = $Interactable/InteractableArea
@onready var hitbox: CollisionShape2D = $Hitbox

var unlock_name : String
var open_name : String

##Returns the proper animation name for the door it is
##key is which animation (open or unlock)
func give_animation_name(key : String) -> String:
	var animation_name : String = global.AreaNames.keys()[door_type]
	animation_name = animation_name + "_" + key.to_upper()
	#Creates name that is all uppercase with _ separating words
	#Ex: AMBER_OPEN
	
	return animation_name

func dissipate_fog_of_war() -> void:
	if fog_of_war:
		var tween = get_tree().create_tween()
		tween.tween_property(fog_of_war,"modulate:a",0,1.0)
		await tween.finished
		tween.kill()

func _ready() -> void:
	unlock_name = give_animation_name("unlock")
	open_name = give_animation_name("open")
	#Prevents from using give_animation_name() over and over again
	
	animated_sprite_2d.frame = 0
	interactable.is_interactable = true
	hitbox.disabled = false
	#Intial setup
	
	if is_locked_door:
		locked_door_ready()
	else:
		normal_door_ready()
	
	interactable.interact = open_door
	#Sets the interact function to the open door defined in here

func locked_door_ready() -> void:
	animated_sprite_2d.animation = unlock_name
	#Sets it to locked door sprite
	
	if global.player_keys_found < door_type:
	#Locks the door if the player doesn't have the appropiate key
		interactable.interact_name = "This door is locked. You must obtain the key."
	else:
		interactable.interact_name = "Press E to unlock door"
	
func normal_door_ready() -> void:
	animated_sprite_2d.animation = open_name
	#Sets it to normal door sprite
	
	interactable.interact_name = "Press E to open door"
	
	
func open_door() -> void:
	if !is_locked_door or global.player_keys_found >= door_type:
	#Only opens if the door is normal or if key is found
		if is_locked_door:
			animated_sprite_2d.play(unlock_name)
			
			await  animated_sprite_2d.animation_finished
			#Plays unlock animation if locked door and waits until animation is finished to open
			
			dissipate_fog_of_war()
			#Dissipates occuled areas if there are any
			
			is_locked_door = false
			normal_door_ready()
			#Makes it a normal door after unlocking
		
		animated_sprite_2d.play(open_name)
		hitbox.disabled = true
		#Plays open animation and disables hitbox
		
		await interactable.area_exited
		await get_tree().create_timer(0.25).timeout
		#Waits until 0.25 seconds after the player walked out of the door's range
		
		animated_sprite_2d.play_backwards(open_name)
		hitbox.disabled = false
		#Closes door and turn back on appropiate hitbox
		
