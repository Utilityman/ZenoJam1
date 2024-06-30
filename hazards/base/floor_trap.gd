class_name FloorTrap extends Trap

signal change_state

@export var active_duration: float = 1.0

@onready var hitbox: Area2D = $HitBox
@onready var collision_shape: CollisionShape2D = $HitBox/CollisionShape2D
@onready var timer: Timer = $Timer

var active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(trigger)
	if initial_delay > 0.0:
		activate_delay(initial_delay)
	elif interval > 0.0:
		activate_delay(0.001)

func activate_delay (delay: float):
	if delay > 0:
		timer.wait_time = delay
		timer.start()

func trigger () -> void:
	if active: return
	active = true

	change_state.emit(true)
	collision_shape.disabled = false
	await get_tree().create_timer(active_duration).timeout
	change_state.emit(false)
	active = false
	collision_shape.disabled = true

	if interval > 0.0: 
		activate_delay(interval)
