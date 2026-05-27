extends ColorRect

var enemy : Enemy

func _ready() -> void:
	enemy = get_parent()
	if enemy.debug_show_boundary:
		show()
		size = Vector2(enemy.boundary_width,enemy.boundary_height)
		position = enemy.boundary_position
	else:
		hide()
