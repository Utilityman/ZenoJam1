class_name PressurePlate extends TriggerArea


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	player_entered.connect(_on_player_entered)
	player_exited.connect(_on_player_exited)

func _on_player_entered ():
	$AnimationPlayer.play("PRESS")

func _on_player_exited ():
	$AnimationPlayer.play("RESET")
