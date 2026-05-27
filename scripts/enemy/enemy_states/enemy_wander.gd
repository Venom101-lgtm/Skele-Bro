extends EnemyState

var direction : Vector2

func enter() -> void:
	nav_agent.target_position = get_random_wander_coord()

func state_process(_state_delta: float) -> void:
	direction = enemy.to_local(nav_agent.get_next_path_position()).normalized()
	if nav_agent.is_target_reached():
		transition.emit(self,"Idle")

func state_physics_process(_state_delta: float) -> void:
	enemy.velocity = enemy.velocity.lerp(stats.wander_speed * direction, stats.friction)

##Gets a random coordinate within the bounding box the enemy is in
func get_random_wander_coord() -> Vector2:
	var wander_coord := enemy.boundary_position
	
	wander_coord.x += randf_range(0,enemy.boundary_width)
	wander_coord.y += randf_range(0,enemy.boundary_height)
	
	return wander_coord
