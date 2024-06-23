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

	body_entered.connect(_on_body_entered)

func _on_body_entered (body: Node2D):
	if body is Player:
		body.hit(self)
		queue_free()

func _on_lifetime_timeout ():
	queue_free()

func _physics_process(delta: float) -> void:
	position.y += delta * speed * direction.y
	position.x += delta * speed * direction.x
