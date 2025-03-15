extends TileMapLayer

@export var target_atlas_coords: Vector2i = Vector2i(0, 0)  # The atlas coordinates of the tile you want to replace
@export var new_atlas_coords: Vector2i = Vector2i(1, 0)     # The atlas coordinates of the tile to replace it with

func replace_tiles():
	print(get_used_rect().position, get_used_rect().end)
	for x in range(get_used_rect().position.x, get_used_rect().end.x):
		for y in range(get_used_rect().position.y, get_used_rect().end.y):
			var cell_pos = Vector2i(x, y)
			var tile_id = get_cell_source_id(cell_pos)  # Layer 0 assumed
			if tile_id != -1:
				var tile_atlas_coords = tile_set.get_item_source_id(tile_id)  # Get atlas coordinates for the tile ID
				
				if tile_atlas_coords == target_atlas_coords:
					set_cell(cell_pos, tile_set.find_tile_by_source_coords(new_atlas_coords))  # Replace tile using atlas coordinates

func _ready():
	print("RUNNING")
	#replace_tiles()
