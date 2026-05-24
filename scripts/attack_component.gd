class_name AttackComponent
extends Area2D

@export var attack_damage : int

func _init() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area):
	if area is HitboxComponent:
		area.take_damage(attack_damage)
