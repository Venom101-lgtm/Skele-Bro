class_name HitboxComponent
extends Area2D

@export var health_component : HealthComponent

func take_damage(attack: int) -> void:
	if health_component:
		health_component.damage(attack)
