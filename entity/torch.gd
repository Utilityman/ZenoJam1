class_name Torch extends Area2D

@export var is_held: bool = true
@export var has_hit_wall: bool = false
@export var torch_velocity: Vector2

@onready var torch_sprite: Sprite2D = $Sprite2D
@onready var torch_particles: GPUParticles2D = $GPUParticles2D

var swing_x_axis: bool
var swing_positivity: int
var fly_time: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_entered)
	Global.orb_obtained.connect(_on_orb_obtained)
	if Global.player_has_orb:
		torch_sprite.modulate = Global.orb_modulate
		torch_particles.modulate = Global.orb_modulate

func _on_orb_obtained ():
	var tween: Tween = get_tree().create_tween()
	tween.parallel()
	tween.tween_property(torch_sprite, "modulate", Global.orb_modulate, 1.0)
	tween.tween_property(torch_particles, "modulate", Global.orb_modulate, 1.0)

func _on_body_entered(node: Node2D):
	if not is_held and node is BurningTileMap:
		var level_map: BurningTileMap = node
		has_hit_wall = true
		level_map.fire_contact_any_one_nearby(self.global_position)

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
	
	$TorchFlying.play()
	has_hit_wall = false
	is_held = false
	fly_time = 0.0

	# set the correct global position once it becomes a top level scene
	var _position = global_position
	top_level = true
	global_position = _position

	# properties that make this move
	torch_velocity = Vector2(direction)
	torch_velocity *= 120
	swing_x_axis = abs(torch_velocity.x) < abs(torch_velocity.y)
	swing_positivity = (randi() & 2) - 1


func _on_area_exited(area:Area2D) -> void:
	pass # Replace with function body.
