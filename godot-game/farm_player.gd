extends CharacterBody2D
@export var speed = 400
var screen_size
signal hit 


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	get_node("../water_tank/water").hide()
	
	#hide()

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
	#var tilemap = get_node("../TileMapLayer")
	#if collision:
		#var collision_pos = collision.get_position()
		#var adjusted_pos = collision_pos - collision.get_normal() * 0.1
		#var tile_pos = tilemap.local_to_map(adjusted_pos)
		#var tile_id = tilemap.get_cell_atlas_coords(tile_pos)
		#if tile_id.x == 24:
			#get_node("../water_tank/water").show()
			#if Input.is_action_just_pressed("e"):
				#get_node("../water_tank/water").hide()
		#else:
			#get_node("../water_tank/water").hide()
	#else:
		#get_node("../water_tank/water").hide()
		
		
	
	
	



func _on_visibility_screen_exited():
	get_tree().change_scene_to_file("res://Village.tscn") # Replace with function body.
