class_name AnimatedTextureRect extends TextureRect

@export var sprites: SpriteFrames
@export var current_animation = "default"
@export var frame_index = 0
@export_range(0.0, INF, 0.001) var speed_scale := 1.0
@export var auto_play := false
@export var playing := false
var refresh_rate = 1.0
var fps = 30
var frame_delta = 0

# Store a preloaded static texture
var static_texture : Texture = load("res://assets/farmBackground.png")

var state = Weather.week_states[Weather.week_array[Weather.week]]

func _ready():
	fps = sprites.get_animation_speed(current_animation)
	refresh_rate = sprites.get_frame_duration(current_animation, frame_index)
	if auto_play:
		play()

func _process(delta):
	if state == 'rain':
		# Play the animation if the condition is met
		if sprites == null or playing == false:
			return
		if not sprites.has_animation(current_animation):
			playing = false
			assert(false, "Animation doesn't exist")
		get_animation_data(current_animation)
		frame_delta += (speed_scale * delta)
		if frame_delta >= (refresh_rate / fps):
			texture = get_next_frame()  # Get the next frame of the animation
			frame_delta = 0
	else:
		# Use the preloaded static texture when condition is not met
		texture = static_texture
	
func get_next_frame():
	frame_index += 1
	var frame_count = sprites.get_frame_count(current_animation)
	if frame_index >= frame_count:
		frame_index = 0
		if not sprites.get_animation_loop(current_animation):
			playing = false
	get_animation_data(current_animation)
	return sprites.get_frame_texture(current_animation, frame_index)

func play(animation_name : String = current_animation):
	frame_index = 0
	frame_delta = 0
	current_animation = animation_name
	get_animation_data(current_animation)
	playing = true

func get_animation_data(animation):
	fps = sprites.get_animation_speed(current_animation)
	refresh_rate = sprites.get_frame_duration(current_animation, frame_index)

func resume():
	playing = true

func pause():
	playing = false

func stop():
	frame_index = 0
	playing = false
