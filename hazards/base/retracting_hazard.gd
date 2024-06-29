class_name RetractingHazard extends Trap

@export var destination: Vector2 = Vector2.ZERO
@export var time_to_destination: float = 1.0
@export var time_to_retract: float = 3.0

@onready var timer: Timer = $Timer
@onready var retractor: Node2D = $Retractor

var processing: bool = false
var initial_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initial_position = retractor.position
	timer.timeout.connect(trigger)

	if initial_delay > 0.0:
		activate_delay(initial_delay)
	elif interval > 0.0:
		activate_delay(0.001)

func activate_delay (delay: float):
	if delay > 0:
		timer.wait_time = delay
		timer.start()


func trigger ():
	# if we're currently processsing, don't do anything
	if processing: return
	# otherwise set processing to true, and start tweening between locations
	processing = true

	var destination_real: Vector2 = initial_position + destination
	var tween: Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(retractor, "position", destination_real, time_to_destination)
	tween.tween_callback(_on_reach_destination)

func _on_reach_destination ():
	var tween: Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT_IN)
	tween.tween_property(retractor, "position", initial_position, time_to_retract)
	tween.tween_callback(_on_finish)

func _on_finish ():
	processing = false
	activate_delay(interval)

