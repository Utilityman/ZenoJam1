class_name Fire extends Area2D

# TODO: I want to have the fire particles NOT be affected by the light - it seems like a shader could do that

signal spread

@export var light_growth_rate: float = 0.25
@export var particle_growth_rate: float = 1.0

@onready var spread_timer: Timer = $SpreadTimer
@onready var particles: GPUParticles2D = $%GPUParticles2D

var particle_growth: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spread_timer.timeout.connect(_on_spread)
	# TODO: maybe check the distance from the player to "cheat" and spread faster when further away
	spread_timer.start()

func _on_spread ():
	spread.emit(self.position)

func _process(delta: float) -> void:
	var particlle_scale: float = min(particles.scale.x + delta * light_growth_rate, 8)
	particles.scale.x = particlle_scale
	particles.scale.y = particlle_scale
	particles.amount_ratio += delta * light_growth_rate

	# TODO: also grow the Area2D so that we can slow the player caught in the area

