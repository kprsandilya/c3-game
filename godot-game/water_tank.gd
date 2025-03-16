extends Area2D

@onready var message_label = get_node("../water_tank/water")  # Assign the "Press F to water" label in the Inspector
var player_inside = false

func _ready():
	if message_label:
		message_label.hide()  # Hide the message at the start
		

func _on_body_entered(body):
	if body is CharacterBody2D:  # If the player enters the area
		message_label.show()
		player_inside = true

func _on_body_exited(body):
	if body is CharacterBody2D:  # If the player leaves the area
		message_label.hide()
		player_inside = false

func _process(delta):
	if player_inside and Input.is_action_just_pressed("e") and Weather.water_level > 0:
		Weather.water_level -= 20
		print(Weather.water_level)
