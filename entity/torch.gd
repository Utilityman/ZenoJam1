class_name Torch extends Area2D

# TODO: should the torch follow the player mouse?


@export var is_held: bool = true
@export var has_hit_wall: bool = false
@export var torch_velocity: Vector2

var swing_x_axis: bool
var swing_positivity: int
var fly_time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(node: Node2D):
	if node.is_in_group("FLAMABLE"):
		print("Node:" + str(node))
		has_hit_wall = true
		# node.enflame(torch)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not is_held and not has_hit_wall:
		fly_time += delta
		global_position += torch_velocity * delta
		if swing_x_axis:
			torch_velocity.x += fly_time * swing_positivity
		else:
			torch_velocity.y += fly_time * swing_positivity

func set_moving (direction: Vector2):
	# if it's not held, we don't need to do anything - it's already moving
	if not is_held: return
	has_hit_wall = false

	is_held = false
	fly_time = 0.0

	# set the correct global position once it becomes a top level scene
	print("Current Position:" + str(global_position))
	var _position = global_position
	top_level = true
	global_position = _position
	print("After Set Moving Position:" + str(global_position))

	# properties that make this move
	torch_velocity = Vector2(direction)
	torch_velocity *= 120
	swing_x_axis = abs(torch_velocity.x) < abs(torch_velocity.y)
	swing_positivity = (randi() & 2) - 1
