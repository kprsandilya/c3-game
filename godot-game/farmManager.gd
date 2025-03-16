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

var health_array = [70, 60, 50, 40]

# Manually set Y-coordinates for each row based on grassy positions
var row_y_positions = [250, 350, 450, 550]  # Adjust these based on your image
var seedling_array = []
var seedling_types = []
var type_array = [0, 1, 2, 3]

func _ready():
	place_seedlings()
	change_texture()
	update_health()
	#for row in seedling_array:
		#for seedling in row:
#
			#var plant_type = seedling.get_meta("plant_health")
			#print(seedling)  # Get stored plant type
	

#Used ChatGPT to help generate function, Prompt: How can I generate seedlings
#on generation in an efficient manner.
func place_seedlings():
	#var row_array= []
	for row in range(row_y_positions.size()):
		var row_array = []
		for col in range(column_count):
			var seedling = seedling_scene.instantiate()
			var x_pos = start_x + col * column_spacing
			var y_pos = row_y_positions[row]  # Use manual Y-coordinate
			seedling.position = Vector2(x_pos, y_pos)
			
			seedling.set_meta("plant_type", type_array[row])
			seedling.set_meta("plant_health", health_array[row])
			add_child(seedling)
			row_array.append(seedling)
			
		seedling_array.append(row_array)

func change_texture():
	for row in seedling_array:
		for seedling in row:
			var sprite = seedling.get_node("seedsprite")
			var plant_type = seedling.get_meta("plant_type")  # Get stored plant type

			if Weather.week > 1:
				# Set texture based on the stored plant type
				if plant_type == 0:
					sprite.texture = potato_texture
				elif plant_type == 1:
					sprite.texture = fava_texture
				elif plant_type == 2:
					sprite.texture = quinoa_texture
				elif plant_type == 3:
					sprite.texture = ichu_texture

func update_health():
	var state = Weather.week_states[Weather.week_array[Weather.week]]
	var increment = -10;
	if state == "rain":
		increment = 10;
	elif state == "drought":
		increment = -20
	elif state == "snow":
		increment = 0
	for row in seedling_array:
		for seedling in row:
			seedling.set_meta("plant_health", seedling.get_meta("plant_health")  + increment)
			print(seedling.get_meta("plant_health"))
		
