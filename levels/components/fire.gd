class_name Fire extends Area2D

# TODO: I want to have the fire particles NOT be affected by the light - it seems like a shader could do that

signal spread

@export var light_growth_rate: float = 0.25
@export var particle_growth_rate: float = 1.0

@onready var spread_timer: Timer = $SpreadTimer
@onready var particles: GPUParticles2D = $%GPUParticles2D
@onready var fire_growth_shape: CollisionShape2D = $FireGrowthShape
@onready var fire_origin_area: Area2D = $FireOriginArea

var particle_growth: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fire_origin_area.area_entered.connect(_on_fire_origin_entered)
	spread_timer.timeout.connect(_on_spread)
	# TODO: maybe check the distance from the player to "cheat" and spread faster when further away
	spread_timer.start()

func _on_spread ():
	spread.emit(self.position)

# TODO: I want the fire to consume other fires' light source if its bigger than the other to 
# 		reduce the PointLight2D count - this isn't quite working yet
func _on_fire_origin_entered (area: Area2D):
	print("Fire Origin Entered:" + str(area))

func _process(delta: float) -> void:
	var particle_scale: float = min(particles.scale.x + delta * light_growth_rate, 8)
	particles.scale.x = particle_scale
	particles.scale.y = particle_scale
	particles.amount_ratio += delta * light_growth_rate

	fire_growth_shape.scale.x += delta * 1.2
	fire_growth_shape.scale.y += delta * 1.2

	# TODO: also grow the Area2D so that we can slow the player caught in the area
	# TODO: also I want this to grow so that it could cross a hallway
	# TODO: also I want this to grow so that it can consume PointLight2Ds that it encompasses

