extends Node2D

@export var seedling_scene = preload("res://seedling.tscn")  # Load the seedling scene

# Number of columns
var column_count = 14  
var column_spacing = 72  # Adjust for spacing
var start_x = 58  # Adjust for horizontal alignment

# Manually set Y-coordinates for each row based on grassy positions
var row_y_positions = [250, 350, 450, 550]  # Adjust these based on your image
var seedling_array = []

func _ready():
	place_seedlings()
	print_seedlings()

func place_seedlings():
	var row_array= []
	for row in range(row_y_positions.size()):
		for col in range(column_count):
			var seedling = seedling_scene.instantiate()
			var x_pos = start_x + col * column_spacing
			var y_pos = row_y_positions[row]  # Use manual Y-coordinate
			seedling.position = Vector2(x_pos, y_pos)
			add_child(seedling)
			row_array.append(seedling)
	seedling_array.append(row_array)

func print_seedlings():
	var count = 0
	for row in seedling_array:
		for seedling in row:
			count+=1
			print("Seedling position: ", seedling.position)
	print(count)
