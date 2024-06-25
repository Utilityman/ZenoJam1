class_name LevelMap extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# TODO: this is where tiles should probably discover their adjacent tiles for burning purposes
	pass

func _input(event: InputEvent) -> void:
	# temporary code to manually trigger fire
	if event is InputEventMouseButton:
		fire_contact(get_local_mouse_position())

func fire_contact (hit_position: Vector2):
	print("FIRE CONTACT!!!")
	var map_cell: Vector2i = local_to_map(hit_position)
	for layer in range(get_layers_count()):
		var tile_data: TileData = get_cell_tile_data(0, map_cell)
		var custom_data = tile_data.get_custom_data("burnable")
		print(tile_data)
		print(custom_data)

