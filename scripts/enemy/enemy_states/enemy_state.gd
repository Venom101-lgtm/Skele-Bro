@abstract
extends State
class_name EnemyState

var enemy : Enemy
var stats : EnemyStats

@onready var nav_agent: NavigationAgent2D = %NavigationAgent2D

func _ready() -> void:
	enemy = find_enemy()
	stats = enemy.stats
	nav_agent.target_desired_distance = 8

func find_enemy() -> Enemy:
	var current_parent = get_parent()
	
	while current_parent:
		if current_parent is Enemy:
			return current_parent
		
		current_parent = current_parent.get_parent()
	
	return null
