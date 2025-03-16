extends Control

@onready var pot = get_node("Panel/HBoxContainer/VBoxContainer2/BoxContainer/HBoxContainer/RichTextLabel")
@onready var fava = get_node("Panel/HBoxContainer/VBoxContainer2/BoxContainer2/HBoxContainer/RichTextLabel")
@onready var quinoa = get_node("Panel/HBoxContainer/VBoxContainer2/BoxContainer3/HBoxContainer/RichTextLabel")
@onready var ichu = get_node("Panel/HBoxContainer/VBoxContainer2/BoxContainer4/HBoxContainer/RichTextLabel")

@onready var sol = get_node("Panel/RichTextLabel2")

@onready var array = [1,1,1,1]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pot.text = str(Weather.plant_array[0])
	fava.text = str(Weather.plant_array[1])
	quinoa.text = str(Weather.plant_array[2])
	ichu.text = str(Weather.plant_array[3])
	sol.text = str("SOL: ", Weather.sol)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var flag = 0
	for item in array:
		if item == 1:
			flag = 1
	if flag == 0:
		get_tree().change_scene_to_file("res://End.tscn")


func _on_ichu_pressed() -> void:
	Weather.sol += Weather.sol_per_plant[3] * Weather.plant_array[3]
	array[3] = 0
	$Panel/HBoxContainer/VBoxContainer2/BoxContainer4.modulate.a = 0
	$Panel/HBoxContainer/VBoxContainer2/BoxContainer4/Sprite2D.visible = false
	sol.text = str("SOL: ", Weather.sol)
	print("ICHU")


func _on_quinoa_pressed() -> void:
	Weather.sol += Weather.sol_per_plant[2] * Weather.plant_array[2]
	$Panel/HBoxContainer/VBoxContainer2/BoxContainer3.modulate.a = 0
	$Panel/HBoxContainer/VBoxContainer2/BoxContainer3/Sprite2D.visible = false
	array[2] = 0
	sol.text = str("SOL: ", Weather.sol)
	print("QUINOA")


func _on_fava_pressed() -> void:
	Weather.sol += Weather.sol_per_plant[1] * Weather.plant_array[1]
	$Panel/HBoxContainer/VBoxContainer2/BoxContainer2/Sprite2D.visible = false
	$Panel/HBoxContainer/VBoxContainer2/BoxContainer2.modulate.a = 0
	array[1] = 0
	sol.text = str("SOL: ", Weather.sol)
	print("FAVA")


func _on_potato_pressed() -> void:
	Weather.sol += Weather.sol_per_plant[0] * Weather.plant_array[0]
	$Panel/HBoxContainer/VBoxContainer2/BoxContainer/Sprite2D.visible = false
	$Panel/HBoxContainer/VBoxContainer2/BoxContainer.modulate.a = 0
	array[0] = 0
	sol.text = str("SOL: ", Weather.sol)
	print("POTATO")
