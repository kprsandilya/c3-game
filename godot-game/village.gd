extends Node2D

@onready var num = randi_range(5, 10)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var npc_scene = load("npc.tscn")
	
	for i in range(0, num):
		var npc_instance = npc_scene.instantiate()

		# Set a random position for the NPC (you can adjust this as needed)
		npc_instance.position = Vector2(randf_range(100, 2500), randf_range(350, 450))  # Random position within the screen

		# Add the NPC instance to the current scene
		add_child(npc_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
