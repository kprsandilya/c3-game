extends CharacterBody2D
@export var speed = 400
var screen_size
signal hit 


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
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


func _on_visibility_screen_exited():
	get_tree().change_scene_to_file("res://Village.tscn") # Replace with function body.
