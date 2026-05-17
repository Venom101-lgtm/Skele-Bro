extends Node2D

@onready var interact_label: Label = $CanvasLayer/InteractLabel
var interactions_nearby := []
#An array that hold all possible interactions nearby
var can_interact := true
#Whether or not the player can interact

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact") and can_interact:
		if interactions_nearby:
		#Temperarily makes player uninteractable until the current interaction is done
			can_interact = false
			interact_label.hide()
			
			await interactions_nearby[0].interact.call() 
			
			can_interact = true

func _process(_delta: float) -> void:
	if interactions_nearby and can_interact:
	#Checks to see if there's anything interactable nearby
		interactions_nearby.sort_custom(sort_by_nearest) #sorts them by nearest
		if interactions_nearby[0].is_interactable:
		#If the thing nearest is interactable set the text and show the label
			interact_label.text = interactions_nearby[0].interact_name
			interact_label.show()
	else:
		interact_label.hide()

##Sort the interactables by which is nearest to the player
func sort_by_nearest(area1,area2) -> bool:
	var area1_dist = global_position.distance_to(area1.global_position)
	var area2_dist = global_position.distance_to(area2.global_position)
	return area1_dist < area2_dist
	

func _on_interact_range_area_entered(area: Area2D) -> void:
	interactions_nearby.push_back(area)
	#Adds an interactable area to nearby ones listing first to last entered



func _on_interact_range_area_exited(area: Area2D) -> void:
	interactions_nearby.erase(area)
	#Removes interactable area once it leaves interactable range
