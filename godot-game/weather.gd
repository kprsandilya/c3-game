# PlayerProperties.gd
extends Node
class_name PlayerProperties

var plant_array: Array = [13, 13, 13, 13]
var plant_health: Array = [70, 60, 50, 40]
var plant_hidden: Array = [false, false, false, false]

var sol_per_plant: Array = [5, 10, 15, 20]

var flags: Array = [false, false]

var sol: int = -10

#Goes up to 8
var month: int = 0

#Goes to 32
var week: int = 0

var water_level: int = 100

var weather_type: String = ""

# Initialize the resource with given data
func _init():
	pass

# Print player properties
func Print() -> void:
	print("Potato = %d Fava = %d Quinoa = %d Ichu = %d" % [plant_array[0], plant_array[1], plant_array[2], plant_array[3]])
	print("Potato = %d Fava = %d Quinoa = %d Ichu = %d" % [plant_health[0], plant_health[1], plant_health[2], plant_health[3]])
	print("Potato = %d Fava = %d Quinoa = %d Ichu = %d" % [plant_hidden[0], plant_hidden[1], plant_hidden[2], plant_hidden[3]])
