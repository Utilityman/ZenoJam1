class_name TreasureHoard extends BaseLevel

@onready var orb: OrbOfGoblinKind = $OrbOfGoblinKind
@onready var orb_area: Area2D = $OrbOfGoblinKind/OrbArea

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	orb_area.body_entered.connect(_on_orb_area_entered)

func _on_orb_area_entered (body: Node2D):
	if body is Player:
		orb.take_orb(body)