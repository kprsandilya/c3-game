extends Node2D

@export var current_state = "healthy"

var health 
var type



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update_health():
	if current_state == "drought":
		health -= 20
	else:
		health -= 10

func rain():
	health += 20
	
