extends PointLight2D

@export var light_growth_rate: float = 0.25

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	texture_scale += delta * light_growth_rate

