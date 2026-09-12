extends Node2D


@onready var area = $background/door
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.finish.connect(_next)
	
func _next():
	get_tree().change_scene_to_file("res://scene/corridor_4.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
