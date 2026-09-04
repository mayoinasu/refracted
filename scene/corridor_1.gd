extends Node2D

@onready var closeup: CanvasLayer = $hint/display
@onready var area = $hint/Area2D

var done = false
var player_inside: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area.read.connect(_open)
		

func _open():
	$background/door/closed.visible = false
	$background/door/opened.visible = true
	done = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	$hint/Label.visible = true
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$hint/Label.visible = false


func next_level(body: Node2D) -> void:
	if done == true:
		get_tree().change_scene_to_file("res://scene/level_2.tscn")
