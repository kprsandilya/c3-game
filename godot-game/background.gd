extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	update_size()
	get_viewport().connect("size_changed", update_size)

func update_size():
	size = get_viewport_rect().size
