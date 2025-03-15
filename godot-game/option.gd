extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dropdown = $HBoxContainer/Names/Option
	dropdown.get_popup().add_theme_font_size_override("font_size", 24)
	dropdown.selected = 0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_option_item_selected(index: int) -> void:
	print(index)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu.tscn")
