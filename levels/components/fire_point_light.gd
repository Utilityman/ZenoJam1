extends PointLight2D

@export var light_growth_rate: float = 0.5

func _process(delta: float) -> void:
	texture_scale += delta * light_growth_rate
	energy = min(energy + delta * light_growth_rate, 5)

