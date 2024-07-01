class_name BatHazard extends SwingingHazard

@onready var bat_animator = $%BatAnimator

func _ready():
	super._ready()
	bat_animator.play("fly")
