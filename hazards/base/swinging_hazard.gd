class_name SwingingHazard extends Trap

@export var speed :float = 150.0
@export var swing_back: bool = true
@onready var _follow :PathFollow2D = $SwingingPathFollower
var activated: bool = false
var swinging_forward: bool = true

func _ready():
	if initial_delay > 0.0:
		activate_delay(initial_delay)
	elif interval > 0.0:
		activate_delay(0.001)

func _physics_process(delta):
	if activated:
		var positivity: float = 1.0
		if !swinging_forward: positivity = -1
		_follow.progress += speed * delta * positivity
		
		if _follow.progress_ratio >= 1.0:
			if swing_back:
				swinging_forward = false
			else:
				swing_done()
		elif _follow.progress_ratio <= 0.0:
			swing_done()

func activate_delay(time: float):
	print("activating")
	await get_tree().create_timer(time).timeout
	trigger()
	
func swing_done():
	activated = false
	swinging_forward = true
	_follow.set_progress(0)
	if interval >= 0.0:
		activate_delay(interval)
		
func trigger():
	if activated: return
	activated = true
	_follow.set_progress(0)
	
	
