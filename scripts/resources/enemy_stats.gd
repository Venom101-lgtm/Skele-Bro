extends Resource
class_name EnemyStats

@export var max_health : int
@export var damage : int

@export var max_speed : float
@export var friction : float

#Wandering Variables
@export var wander_speed : float
@export var wander_min_wait_time : float
@export var wander_max_wait_time : float

##Returns a random wait time between wanderings
func get_random_wait_time() -> float:
	return randf_range(wander_min_wait_time,wander_max_wait_time)
