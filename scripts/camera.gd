extends Camera2D

@export var player : CharacterBody2D
@export var specified_top_limit : int
@export var specified_bottom_limit : int
@export var specified_left_limit : int
@export var specified_right_limit : int

func _ready() -> void:
	limit_top = specified_top_limit
	limit_bottom = specified_bottom_limit
	limit_left = specified_left_limit
	limit_right = specified_right_limit
