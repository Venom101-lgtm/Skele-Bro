extends CharacterBody2D
class_name SkeleBro

@onready var health_component: HealthComponent = $HealthComponent
@onready var attack_hitbox: CollisionShape2D = $HitboxComponent/Hitbox
@onready var slash_sprite: Sprite2D = $HitboxComponent/SlashSprite

func _ready() -> void:
	health_component.health_changed.connect(_print_health)
	attack_hitbox.disabled = true
	slash_sprite.hide()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func _print_health(new_amount) -> void:
	print(new_amount)
