extends Node2D

@export var seedling_scene = preload("res://seedling.tscn") 
@export var potato_texture = preload("res://potato_healthy.png")
@export var fava_texture = preload("res://fava_healthy.png")
@export var quinoa_texture = preload("res://quinoa_healthy.png")
@export var ichu_texture = preload("res://ichu_healthy.png")


# Number of columns
var column_count = 14  
var column_spacing = 72  # Adjust for spacing
var start_x = 58  # Adjust for horizontal alignment
var type

var plant_types = [1, 2, 3, 4]

# Manually set Y-coordinates for each row based on grassy positions
var row_y_positions = [250, 350, 450, 550]  # Adjust these based on your image
var seedling_array = []
var seedling_types = []
var type_array = [0, 1, 2, 3]

func _ready():
	place_seedlings()
	await get_tree().create_timer(3).timeout
	change_texture()

#Used ChatGPT to help generate function, Prompt: How can I generate seedlings
#on generation in an efficient manner.
func place_seedlings():
	var row_array= []
	for row in range(row_y_positions.size()):
		print(row)
		for col in range(column_count):
			var seedling = seedling_scene.instantiate()
			var x_pos = start_x + col * column_spacing
			var y_pos = row_y_positions[row]  # Use manual Y-coordinate
			seedling.position = Vector2(x_pos, y_pos)
			
			seedling.set_meta("plant_type", type_array[row])
			add_child(seedling)
			row_array.append(seedling)
			
		seedling_array.append(row_array)

func change_texture():
	for row in seedling_array:
		for seedling in row:
			var sprite = seedling.get_node("seedsprite")
			var plant_type = seedling.get_meta("plant_type")  # Get stored plant type

			# Set texture based on the stored plant type
			if plant_type == 0:
				sprite.texture = potato_texture
			elif plant_type == 1:
				sprite.texture = fava_texture
			elif plant_type == 2:
				sprite.texture = quinoa_texture
			elif plant_type == 3:
				sprite.texture = ichu_texture
