extends Area2D

@export var hazards: Array[Trap]
@export var times_can_activate: int = -1   

# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(on_body_entered)
	self.body_exited.connect(on_body_exited)

func on_body_entered(body:Node2D):
	if times_can_activate > 0 or times_can_activate == -1:
		if times_can_activate > 0: times_can_activate -= 1
		for hazard in hazards:
			hazard.trigger()
		$AnimationPlayer.play("pushed")
	
func on_body_exited(body:Node2D):
	$AnimationPlayer.play("RESET")
	

	
	
