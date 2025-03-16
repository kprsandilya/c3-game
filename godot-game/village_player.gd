extends CharacterBody2D
@export var speed = 400
var screen_size
signal hit 


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	con.hide()
	#hide()

@onready var con = get_node("../CanvasLayer/Control")

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
	
	if collision != null and Input.is_action_just_pressed("e"):
		var name = collision.get_collider().name

		if name == "Old Man":
			var con = get_tree().get_root().find_child("Control", true, false)

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



func _on_visibility_screen_exited():
	get_tree().change_scene_to_file("res://Village.tscn") # Replace with function body.
