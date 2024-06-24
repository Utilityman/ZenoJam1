class_name ProjectileHazard extends Area2D

# TODO: cool animations and stuff on spawn/despawn ?

@export var shape: Shape2D
@export var lifetime: float = 5.0
@export var speed: float = 60.0
@export var direction: Vector2 = Vector2.ZERO

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var lifetime_timer: Timer = $LifetimeTimer

func _ready() -> void:
	if not collision_shape.shape:
		collision_shape.shape = shape
	lifetime_timer.wait_time = lifetime
	lifetime_timer.timeout.connect(_on_lifetime_timeout)
	lifetime_timer.start() 

func _on_lifetime_timeout ():
	queue_free()

func _physics_process(delta: float) -> void:
	position.y += delta * speed * direction.y
	position.x += delta * speed * direction.x
