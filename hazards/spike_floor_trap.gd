class_name SpikeFloorTrap extends FloorTrap

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	change_state.connect(_on_state_change)

func _on_state_change (active: bool):
	if active:
		animation_player.play("EXTEND")
	else:
		animation_player.play("RETRACT")

