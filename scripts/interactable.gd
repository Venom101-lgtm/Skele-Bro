extends Area2D

@export var interact_name : String = "" #The message it will display
@export var is_interactable : bool = true #Whether it can be interacted with or not

#The function that will handle what to do when interacted with
var interact : Callable = func():
	pass
