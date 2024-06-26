class_name BurningTileMap extends TileMap


var fire_scene: PackedScene = preload("res://entity/fire.tscn")
var point_light_scene: PackedScene = preload("res://entity/fire_point_light.tscn")
var first_tile: Vector2i
var burning_tiles: Array[Vector2i] = []

func _input(event: InputEvent) -> void:
	# temporary code to manually trigger fire
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		fire_contact(get_local_mouse_position())
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 2:
		var cell: Vector2i = local_to_map(get_local_mouse_position())
		print("Tile Is: " + str(cell))
		print("Should start fire here:" + str(should_start_fire_in_cell(cell)))

func fire_contact_any_one_nearby (hit_position: Vector2):
	var map_cell: Vector2i = local_to_map(hit_position)
	var cells_to_light: Array[Vector2i] = get_surrounding_cells(map_cell)
	cells_to_light.append(map_cell)
	cells_to_light.reverse()
	for cell in cells_to_light:
		if should_start_fire_in_cell(cell):
			start_fire(cell)
			break

func fire_contact (hit_position: Vector2):
	var map_cell: Vector2i = local_to_map(hit_position)
	if should_start_fire_in_cell(map_cell):
		start_fire(map_cell)

func should_start_fire_in_cell (map_cell: Vector2i):
	var burnable: bool = false
	var burning: bool = false
	for layer in range(self.get_layers_count()):
		var tile_data: TileData = get_cell_tile_data(layer, map_cell)
		if tile_data:
			burnable = burnable || tile_data.get_custom_data("burnable")
			burning = burning || burning_tiles.has(map_cell)

	return burnable and not burning

func start_fire (map_cell: Vector2i):
	if not first_tile: first_tile = map_cell

	# formula to get every other tile (checkered pattern)
	var first_tile_oddness: int = (abs(first_tile.x) + abs(first_tile.y)) % 2
	var map_cell_oddness: int = (abs(map_cell.x) + abs(map_cell.y)) % 2
	var should_emit_light: bool = first_tile_oddness == map_cell_oddness

	burning_tiles.append(map_cell)
	var fire: Fire = fire_scene.instantiate()

	# due to PointLight2D constraints we want to limit the amount of tiles which 
	# actually get point lights - only add the light checkered from the original fire
	if should_emit_light:
		var point_light = point_light_scene.instantiate()
		fire.add_child(point_light)

	fire.position = map_to_local(map_cell)
	call_deferred("add_child", fire)
	fire.spread.connect(fire_spread)

func fire_spread (from_position: Vector2):
	var adjacent_cells: Array[Vector2i] = get_surrounding_cells(local_to_map(from_position))
	for cell: Vector2i in adjacent_cells:
		if should_start_fire_in_cell(cell):
			start_fire(cell)
