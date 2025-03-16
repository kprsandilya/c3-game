extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var title = get_node("RichTextLabel")
	
	if Weather.sol < 100:
		title.text = "BAD END"
	elif Weather.sol < 200:
		title.text = "NORMAL END"
	elif Weather.sol < 300:
		title.text = "GOOD END"
	else:
		title.text = "BEST END"
		
	var info = get_node("Box")
	var string = "Your Statistics: \nPotatoes Sold: " + str(Weather.plant_array[0]) + "\nFava Sold: " \
	 + str(Weather.plant_array[1]) + "\nQuinoa Sold: " + str(Weather.plant_array[2]) + "\nIchu Sold: " + str(Weather.plant_array[3])
	
	info.text = string

	$AudioStreamPlayer.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
