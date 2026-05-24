class_name HealthComponent
extends Node2D

signal died
signal health_changed(new_amount : int)

@export var max_health : int
var current_health : int

func _ready() -> void:
	current_health = max_health
	
func damage(attack: int) -> void:
	current_health -= attack
	health_changed.emit(current_health)
	
	if current_health <= 0:
		died.emit()
