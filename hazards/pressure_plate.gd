extends Area2D

@export var hazards: Array[Trap]   

# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(on_body_entered)
	self.body_exited.connect(on_body_exited)

func on_body_entered(body:Node2D):
	print(body)
	for hazard in hazards:
		hazard.trigger()
	$AnimationPlayer.play("pushed")
	
func on_body_exited(body:Node2D):
	$AnimationPlayer.play("RESET")
	

	
	
