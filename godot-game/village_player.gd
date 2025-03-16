extends CharacterBody2D
@export var speed = 400
var screen_size
signal hit 

var itotal = 0
var i = 0
var iyou = 0

var jtotal = 0
var j = 0
var jyou = 0
@onready var con = get_tree().get_root().find_child("Control", true, false)
@onready var luigi = get_tree().get_root().find_child("Control2", true, false)
@onready var options = get_node("../CanvasLayer/Control/HBo")
@onready var options2 = get_node("../CanvasLayer/Control2/HBo")

@onready var you = preload("res://Player2OldManTextbox.png")
@onready var them = preload("res://OldMan2PlayerTextbox.png")

@onready var farmyou = preload("res://Player2FarmerTextbox.png")
@onready var farmthem = preload("res://Farmer2PlayerTextbox.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	con.hide()
	luigi.hide()
	options.visible = false
	options2.visible = false
	#hide()
	
func set_zero():
	itotal = 0
	i = 0
	iyou = 0

	jtotal = 0
	j = 0
	jyou = 0
	
	get_node("../CanvasLayer/Control/RichTextLabel").text = "HELLO!"
	get_node("../CanvasLayer/Control2/RichTextLabel").text = "HELLO!"
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	elif Input.is_action_pressed("ui_down"):
		velocity.y += 1
	elif Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$sprite.play()
	else:
		$sprite.stop()
	
	if velocity.x != 0:
		$sprite.animation = "walk"
		$sprite.flip_v = false
		$sprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		if velocity.y < 0:
			$sprite.animation = "up"
		else:
			$sprite.animation = "down"
		
	var collision = move_and_collide(velocity * delta)
	
	var tilemap = get_node("../TileMapLayer")
	
	if collision:
		var collision_pos = collision.get_position()
		var adjusted_pos = collision_pos - collision.get_normal() * 0.1
		var tile_pos = tilemap.local_to_map(adjusted_pos)
		var tile_id = tilemap.get_cell_atlas_coords(tile_pos)
		
		print(tile_id.x)

		if tile_id.x == 2:
			get_tree().change_scene_to_file("Store.tscn")
	
	if collision != null and Input.is_action_just_pressed("e"):
		var name = collision.get_collider().name

		if name == "Old Man":

			if con:
				con.visible = not con.visible
				con.queue_redraw()
				con.set_z_index(100)  # Bring to front
				con.size = get_viewport_rect().size
				con.custom_minimum_size = get_viewport_rect().size

				if con.visible:
					velocity = Vector2.ZERO
					$sprite.stop()
					set_process(false)  # Disable movement
				else:
					set_process(true)  # Re-enable movement

				print("Panel toggled:", con.visible)
			else:
				print("Error: Control node not found!")
		elif name == "Luigi":
			
			if luigi:
				luigi.visible = not luigi.visible
				luigi.queue_redraw()
				luigi.set_z_index(100)  # Bring to front
				luigi.size = get_viewport_rect().size
				luigi.custom_minimum_size = get_viewport_rect().size

				if luigi.visible:
					velocity = Vector2.ZERO
					$sprite.stop()
					set_process(false)  # Disable movement
				else:
					set_process(true)  # Re-enable movement

				print("Panel toggled:", luigi.visible)
			else:
				print("Error: Control node not found!")



func _on_visibility_screen_exited():
	get_tree().change_scene_to_file("res://Village.tscn") # Replace with function body.


func _on_button_pressed() -> void:
	var file = FileAccess.open("res://temp.txt", FileAccess.READ)
	var content = file.get_as_text().split('\n')
	
	var file2 = FileAccess.open("res://tempyou.txt", FileAccess.READ)
	var contentyou = file2.get_as_text().split('\n')
	
	var text = get_node("../CanvasLayer/Control/RichTextLabel")
	var bg = get_node("../CanvasLayer/Control/Panel/TextureRect")
	
	if (iyou == 0):
		options.visible = true
	else:
		options.visible = false
		
	
	if (fmod(itotal, 2) == 1):
		bg.texture = them
		if (i >= content.size()):
			con.visible = false
			set_process(true)
			set_zero()
			return
			
		text.text = content[i]
		i += 1
	else:
		bg.texture = you
		if (iyou >= contentyou.size()):
			con.visible = false
			set_process(true)
			set_zero()
			return
		text.text = contentyou[iyou]
		iyou += 1
		
		
	itotal += 1


func _on_button2_pressed() -> void:
	var file = FileAccess.open("res://temp.txt", FileAccess.READ)
	var content = file.get_as_text().split('\n')
	
	var file2 = FileAccess.open("res://tempyou.txt", FileAccess.READ)
	var contentyou = file2.get_as_text().split('\n')
	
	var text = get_node("../CanvasLayer/Control2/RichTextLabel")
	var bg = get_node("../CanvasLayer/Control2/Panel/TextureRect")
	
	print(contentyou)
	
	if (true):
		
		if (jyou == 0):
			options2.visible = true
		else:
			options2.visible = false
	
		if (fmod(jtotal, 2) == 1):
			bg.texture = farmthem
			if (j >= content.size()):
				luigi.visible = false
				set_process(true)
				set_zero()
				return
				
			text.text = content[j]
			j += 1
		else:
			bg.texture = farmyou
			if (jyou >= contentyou.size()):
				luigi.visible = false
				set_process(true)
				set_zero()
				return
			text.text = contentyou[jyou]
			jyou += 1
			
		jtotal += 1
	else:
		if (fmod(jtotal, 2) == 1):
			bg.texture = farmthem
			if (j >= content.size()):
				luigi.visible = false
				set_process(true)
				set_zero()
				return
				
			text.text = content[j]
			j += 1
		else:
			bg.texture = farmyou
			if (jyou >= contentyou.size()):
				luigi.visible = false
				set_process(true)
				set_zero()
				return
			text.text = contentyou[jyou]
			jyou += 1
			
		jtotal += 1

func _set_option() -> void:
	Weather.Print()
	var file2 = FileAccess.open("res://temp.txt", FileAccess.READ)
	var contentyou = file2.get_as_text().split('\n')

	var text = get_node("../CanvasLayer/Control/RichTextLabel")

	text.text = contentyou[i]
	
	i += 1
	itotal += 1
	
	options.visible = false
		
func _set_option2() -> void:
	Weather.Print()
	var file2 = FileAccess.open("res://temp.txt", FileAccess.READ)
	var contentyou = file2.get_as_text().split('\n')

	var text = get_node("../CanvasLayer/Control2/RichTextLabel")

	text.text = contentyou[j]
	
	j += 1
	jtotal += 1
	
	options2.visible = false
		
func _option2_potato_pressed() -> void:
	Weather.plant_array[0] -= 1

	_set_option2()


func _option2_fava_pressed() -> void:
	Weather.plant_array[1] -= 1
	
	_set_option2()

func _option2_quinoa_pressed() -> void:
	Weather.plant_array[2] -= 1
	_set_option2()


func _option2_ichu_pressed() -> void:
	Weather.plant_array[3] -= 1
	_set_option2()


func _option_potato_pressed() -> void:
	Weather.plant_array[0] -= 1
	_set_option()


func _option_fava_pressed() -> void:
	Weather.plant_array[1] -= 1
	_set_option()

func _option_quinoa_pressed() -> void:
	Weather.plant_array[2] -= 1
	_set_option()


func _option_ichu_pressed() -> void:
	Weather.plant_array[3] -= 1
	_set_option()
