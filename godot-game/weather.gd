# PlayerProperties.gd
extends Node
class_name PlayerProperties

@export var seedling_scene = preload("res://seedling.tscn") 

var plant_array: Array = [14, 14, 14, 14]
var plant_health: Array = [70, 60, 50, 40]
var plant_hidden: Array = [false, false, false, false]

var week_states = ["rain", "snow", "clear", "drought"]
# var max_weeks = 40
var max_weeks = 32
var week_array = []
# var week_array = [2, 2, 1, 0, 2, 3, 0, 0, 2, 2, 3, 2, 0, 0, 0, 2, 2, 2, 0, 2, 2, 3, 3, 2, 2, 2, 0, 2, 0, 2, 0, 0]

var bought = [0,0,0,0]

var sol_per_plant: Array = [5, 10, 15, 20]

var flags: Array = [false, false]

var sol: int = -10

#Goes up to 8
var month: int = 0

#Goes to 32
var week: int = 0

var water_level: int = 100

var weather_type: String = ""

var seedling_array: Array = []

var column_spacing = 72  # Adjust for spacing
var start_x = 58  # Adjust for horizontal alignment

var row_y_positions = [250, 350, 450, 550]  # Adjust these based on your image
var type_array = [0, 1, 2, 3]
var health_array = [70, 60, 50, 40]

var week_changed = false

var weeks_without_rain = 0

# Used ChatGPT to ask for help on how to create weighted probabilities.
# Prompt: I'm writing Godot code where I have 32 weeks and 4 weather conditions.
# I want to assign weather conditions randomly depending on which set of 4 week
# it is, for example, I want to give weeks 0-3 a 20% chance of weather condition 0,
# a 20% chance of weather condition 1, 60% chance of weather condition 2, and a 0%
# chance of weather condition 3. How would I implement this?

var weather_probabilities = [
	# Rain, Snow, Clear, Drought
	[0.2, 0.2, 0.6, 0.0],  # Weeks 0-3: August
	[0.2, 0.2, 0.4, 0.2],  # Weeks 4-7: September
	[0.2, 0, 0.4, 0.6],  # Weeks 8-11: October
	[0.1, 0.5, 0.5, 0.0],  # Weeks 12-15: November
	[0.3, 0.3, 0.3, 0.1],  # Weeks 16-19: December
	[0.4, 0.2, 0.2, 0.2],  # Weeks 20-23: January
	[0.1, 0.4, 0.4, 0.1],  # Weeks 24-27: February
	[0.2, 0.2, 0.2, 0.4]   # Weeks 28-31: March
]

func get_weighted_random(weights: Array) -> int:
	var rand_value = randf()
	var cumulative = 0.0
	for i in range(len(weights)):
		cumulative += weights[i]
		if rand_value < cumulative:
			return i
	return 4 - 1  # Fallback (should not occur if weights sum to 1)

# Initialize the resource with given data
#Used ChatGPT to help generate function, Prompt: How can I generate seedlings
#on generation in an efficient manner.
func _init():
	for week in range(0, max_weeks):
		# Integer Division to select which week it's in
		var week_set = floor(week / 4)

		# Gets the probability of the week
		var random_weather = get_weighted_random(weather_probabilities[week_set])
		
		# Don't want the game to be unwinnable, so force rain if needed
		if(weeks_without_rain >= 8):
			random_weather = 0
		
		# Increment or reset weeks without rain
		if(random_weather == 0):
			weeks_without_rain = 0
		else:
				weeks_without_rain += 1

		# Appends the chosen weather
		week_array.append(random_weather)

		print("Week %d -> Weather %d" % [week, random_weather])
		
	for row in range(0,4):
		var row_array = []
		for col in range(plant_array[row]):
			var seedling = seedling_scene.instantiate()
			var x_pos = start_x + col * column_spacing
			var y_pos = row_y_positions[row]  # Use manual Y-coordinate
			seedling.position = Vector2(x_pos, y_pos)
			
			seedling.set_meta("plant_type", type_array[row])
			seedling.set_meta("plant_health", health_array[row])
			add_child(seedling)
			row_array.append(seedling)
			
		seedling_array.append(row_array)
		
func update_seedlings():
	var i = 0
	for row in range(0, seedling_array.size()):
		var new_row = []  # Store only seedlings that survive

		for seedling in range(0, plant_array[i]):
			# Check for valid seedling references before adding
			if seedling_array[row][seedling] != null and seedling_array[row][seedling].is_inside_tree():
				new_row.append(seedling_array[row][seedling])  # Keep alive seedlings

		seedling_array[i] = new_row  # Update row with only surviving seedlings
		i += 1

		

# Print player properties
func Print() -> void:
	print("Potato = %d Fava = %d Quinoa = %d Ichu = %d" % [plant_array[0], plant_array[1], plant_array[2], plant_array[3]])
	print("Potato = %d Fava = %d Quinoa = %d Ichu = %d" % [plant_health[0], plant_health[1], plant_health[2], plant_health[3]])
	print("Potato = %d Fava = %d Quinoa = %d Ichu = %d" % [plant_hidden[0], plant_hidden[1], plant_hidden[2], plant_hidden[3]])
