extends EnemyState

var wait_time : float

func enter() -> void:
	wait_time = stats.get_random_wait_time()

func state_process(_state_delta: float) -> void:
	if wait_time > 0:
		wait_time -= _state_delta
	else:
		transition.emit(self, "Wander")

func state_physics_process(_state_delta: float) -> void:
	enemy.velocity = enemy.velocity.lerp(Vector2(0,0),stats.friction)
