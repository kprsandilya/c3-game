extends Node2D

@export var seedling_scene = preload("res://seedling.tscn") 
@export var potato_texture = preload("res://potato_healthy.png")
@export var fava_texture = preload("res://fava_healthy.png")
@export var quinoa_texture = preload("res://quinoa_healthy.png")
@export var ichu_texture = preload("res://ichu_healthy.png")
@export var water1 = preload("res://water1.png")
@export var water2 = preload("res://water2.png")
@export var water3 = preload("res://water3.png")
@export var water4 = preload("res://water4.png")
@export var water5 = preload("res://water5.png")
@export var water6 = preload("res://water6.png")
@export var music1 = preload("res://music/contry.mp3")
@export var music2 = preload("res://music/spring.mp3")
@onready var week_label = get_node("week")

var column_spacing = 72  # Adjust for spacing
var start_x = 58  # Adjust for alignment

var state = Weather.week_states[Weather.week_array[Weather.week]]

var health_array = [70, 60, 50, 40]

@onready var message_label = get_node("water_tank/water")
@onready var water_tank_area = get_node("water_tank")

var near_water_tank = false
var row_y_positions = [250, 350, 450, 550]  # Y-coordinates for rows
var type_array = [0, 1, 2, 3]  # Plant types

@export var animated_texture : AnimatedTexture
@export var texture_array : Array

func _ready():
	add_to_group("player")  # Adds the player to the "player" group
	if Weather.week == Weather.max_weeks:
		get_tree().change_scene_to_file("res://Store.tscn")
	$AudioStreamPlayer.play()
	place_seedlings()
	change_texture()
	play_music()
	

	if Weather.week_changed:
		update_health()
		Weather.week_changed = false

	message_label.hide()  # Hide message at start

	#await get_tree().create_timer(0.1).timeout
	near_water_tank = false
	
	print("WATER LEVEL: " + str(Weather.water_level) + " STATE: " + state)
	print(Weather.plant_health[0])
	print(Weather.plant_health[1])
	print(Weather.plant_health[2])
	print(Weather.plant_health[3])
	
	update_week_label()

func _process(_delta):
	var increment = 10
	update_tank()
	if near_water_tank:
		message_label.show()
		if Input.is_action_just_pressed("e") and Weather.water_level > 0:
			Weather.water_level -= 20
			print("WATER LEVEL: " + str(Weather.water_level))
			
			if(Weather.plant_health[0] + increment < health_array[0]):
				Weather.plant_health[0] += increment
			else: Weather.plant_health[0] = health_array[0]
			if(Weather.plant_health[1] + increment < health_array[1]):
				Weather.plant_health[1] += increment
			else: Weather.plant_health[1] = health_array[1]
			if(Weather.plant_health[2] + increment < health_array[2]):
				Weather.plant_health[2] += increment
			else: Weather.plant_health[2] = health_array[2]
			if(Weather.plant_health[3] + increment < health_array[3]):
				Weather.plant_health[3] += increment
			else: Weather.plant_health[3] = health_array[3]
				
			for row in range(Weather.seedling_array.size()):
				for seedling in Weather.seedling_array[row]:
					var new_health = min(seedling.get_meta("plant_health") + increment, health_array[row])
					new_health = Weather.plant_health[row]
					seedling.set_meta("plant_health", new_health)
					
					var health_label = seedling.get_node("health")
					health_label.text = str(new_health)

				if Weather.seedling_array[row]:
					print("HEALTH: " + str(Weather.seedling_array[row][0].get_meta("plant_health")))
	else:
		message_label.hide()
	update_week_label()

func place_seedlings():
	# Clear existing seedlings (for re-generation)
	for row in Weather.seedling_array:
		for seedling in row:
			if seedling != null and seedling.is_inside_tree():
				seedling.queue_free()  # Only call queue_free on valid nodes
	Weather.seedling_array.clear()

	# Now add new seedlings
	for row in range(row_y_positions.size()):
		var row_array = []
		var column_count = Weather.plant_array[row]

		for col in range(column_count):
			var seedling = seedling_scene.instantiate()
			var x_pos = start_x + col * column_spacing
			var y_pos = row_y_positions[row]
			seedling.position = Vector2(x_pos, y_pos)

			seedling.set_meta("plant_type", type_array[row])
			seedling.set_meta("plant_health", health_array[row])
			
			var health_label = seedling.get_node("health")
			health_label.text = str(health_array[row])
			health_label.set("theme_override_colors/font_color", Color.WHITE) # Make text white
			health_label.set("theme_override_font_sizes/font_size", 16)
			
			add_child(seedling)
			row_array.append(seedling)

		Weather.seedling_array.append(row_array)

func change_texture():
	for row in range(Weather.seedling_array.size()):
		for seedling in range(Weather.seedling_array[row].size()):  # FIXED LOOP
			var sprite = Weather.seedling_array[row][seedling].get_node("seedsprite")
			var plant_type = Weather.seedling_array[row][seedling].get_meta("plant_type")

			if Weather.week > 1:
				if plant_type == 0:
					sprite.texture = potato_texture
				elif plant_type == 1:
					sprite.texture = fava_texture
				elif plant_type == 2:
					sprite.texture = quinoa_texture
				elif plant_type == 3:
					sprite.texture = ichu_texture

func _on_WaterTank_area_entered(_area): 
	near_water_tank = true
	message_label.show()  # Show message when player is near the water tank

func _on_WaterTank_area_exited(_area):
	near_water_tank = false
	message_label.hide()  # Show message when player is near the water tank
	
func update_health():
	var increment = 0
	
	if state == "clear":
		increment = -10
		if(Weather.plant_health[0] > 0):
			Weather.plant_health[0] += increment
		if(Weather.plant_health[1] > 0):
			Weather.plant_health[1] += increment
		if(Weather.plant_health[2] > 0):
			Weather.plant_health[2] += increment
		if(Weather.plant_health[3] > 0):
			Weather.plant_health[3] += increment
	elif state == "rain":
		increment = 10
		if(Weather.plant_health[0] + increment < health_array[0]):
			Weather.plant_health[0] += increment
		else: Weather.plant_health[0] = health_array[0]
		if(Weather.plant_health[1] + increment < health_array[1]):
			Weather.plant_health[1] += increment
		else: Weather.plant_health[1] = health_array[1]
		if(Weather.plant_health[2] + increment < health_array[2]):
			Weather.plant_health[2] += increment
		else: Weather.plant_health[2] = health_array[2]
		if(Weather.plant_health[3] + increment < health_array[3]):
			Weather.plant_health[3] += increment
		else: Weather.plant_health[3] = health_array[3]
		if(Weather.water_level < 0):
			Weather.water_level = 0
		Weather.water_level = min(Weather.water_level + 60, 100)
		
	elif state == "drought":
		increment = -20
		if(Weather.plant_health[0] > 0):
			Weather.plant_health[0] += increment
		if(Weather.plant_health[1] > 0):
			Weather.plant_health[1] += increment
		if(Weather.plant_health[2] > 0):
			Weather.plant_health[2] += increment
		if(Weather.plant_health[3] > 0):
			Weather.plant_health[3] += increment
	elif state == "snow":
		increment = -5
		if(Weather.plant_health[0] > 0):
			Weather.plant_health[0] += increment
		if(Weather.plant_health[1] > 0):
			Weather.plant_health[1] += increment
		if(Weather.plant_health[2] > 0):
			Weather.plant_health[2] += increment
		if(Weather.plant_health[3] > 0):
			Weather.plant_health[3] += increment
	print("Weather State:", state, " | Increment:", increment)

	for row in range(Weather.seedling_array.size()):
		var new_row = []  # Store only seedlings that survive

		for seedling in Weather.seedling_array[row]:
			# Check if seedling is still a valid node
			if seedling != null and seedling.is_inside_tree():
				var new_health = seedling.get_meta("plant_health") + increment
				
				if row == 0:
					new_health = Weather.plant_health[0]
				elif row == 1:
					new_health = Weather.plant_health[1]
				elif row == 2:
					new_health = Weather.plant_health[2]
				elif row == 3:
					new_health = Weather.plant_health[3]
				
				seedling.set_meta("plant_health", new_health)
				var health_label = seedling.get_node("health")
				health_label.text = str(new_health)
				

				if new_health > 0:
					new_row.append(seedling)  # Keep alive seedlings
				else:
					seedling.queue_free()  # Remove dead seedlings
					Weather.plant_array[row] -= 1

		Weather.seedling_array[row] = new_row  # Update row with only surviving seedlings

	#if new_health > 0:
	#	new_row.append(seedling)  # Keep alive seedlings
	#else:
	#seedling.queue_free()  # Remove dead seedlings

	# Weather.seedling_array[row] = new_row  # Update row with only surviving seedlings
		
func update_tank():
	var sprite = get_node("water_tank/Sprite2D")
	if Weather.water_level  == 100:
		sprite.texture = water1
	elif Weather.water_level  >= 80:
		sprite.texture = water2
	elif Weather.water_level  >= 60:
		sprite.texture = water3
	elif Weather.water_level  >= 40:
		sprite.texture = water4
	elif Weather.water_level  >= 20:
		sprite.texture = water5
	elif Weather.water_level  == 0:
		sprite.texture = water6

func play_music():
	if state == "rain" or state == "snow" or state == "drought":
		$AudioStreamPlayer.stream = music2
	else:
		$AudioStreamPlayer.stream = music1
	$AudioStreamPlayer.play()  # 

func update_week_label():
	var season
	if(Weather.week < 12):
		season = "Planting Season"
	else:
		season = "Rainy Season"
	week_label.text = "Week: " + str(Weather.week + 1) + "/32 - Weather: "+ str(Weather.week_states[Weather.week_array[Weather.week]]) + ' - ' + str(season)
