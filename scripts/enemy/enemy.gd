extends CharacterBody2D
class_name Enemy

@export var stats : EnemyStats

@onready var enemy_sprite: Sprite2D = $EnemySprite
@onready var health_component: HealthComponent = $HealthComponent

#Variables for boundary of where enemy can wander
@export var boundary_position : Vector2
@export var boundary_width : int
@export var boundary_height : int
@export var debug_show_boundary : bool

func _ready() -> void:
	health_component.max_health = stats.max_health

func _physics_process(_delta: float) -> void:
	move_and_slide()
