class_name TreasureHoard extends BaseLevel

@onready var orb: OrbOfGoblinKind = $OrbOfGoblinKind
@onready var orb_area: Area2D = $OrbOfGoblinKind/OrbArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	orb_area.body_entered.connect(_on_orb_area_entered)
	Global.orb_obtained.connect(_on_orb_obtained)

func _on_orb_obtained ():
	pass
	# Not the treasure you expected, but the treasure you deserved...

func _on_orb_area_entered (body: Node2D):
	if body is Player:
		orb.take_orb(body)