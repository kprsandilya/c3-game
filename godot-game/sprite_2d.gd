#Pulled from this video: https://www.youtube.com/watch?v=VDk-tgnWwEM

extends Sprite2D
@export var speed: float = 100  # Speed at which NPC moves
@export var direction_change_time: float = 2.0  # Time in seconds before NPC changes direction

var velocity = Vector2.ZERO
var screen_size: Vector2
var frames = texture.get_width() / region_rect.size.x
var direction_timer = 0.0

var x_size = 32

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var index = randi_range(0, frames-1)
	region_rect.position.x = index * 160
	
	screen_size = Vector2i(2592, 648)
	set_random_direction()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Move NPC
	position += velocity * delta

	# Change direction periodically
	direction_timer -= delta
	if direction_timer <= 0:
		set_random_direction()
		direction_timer = direction_change_time
		
		if position.x - x_size < 0 or position.x + x_size > screen_size.x:
			print(position, screen_size)
			queue_free()

func set_random_direction():
	# Choose a random angle and speed
	var random_angle = ([-1, 1]).pick_random()
	velocity = Vector2(random_angle, 0) * speed
