extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	print("START")
	get_tree().change_scene_to_file("res://Home Scene.tscn")


func _on_option_pressed() -> void:
	print("OPTION")


func _on_quit_pressed() -> void:
	get_tree().quit()
