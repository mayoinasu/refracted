extends Node2D

@onready var area3 = $hint/paper3/Area2D
@onready var area2 = $hint/paper2/Area2D
@onready var area1 = $hint/paper1/area

var paper1 = false
var paper2 = false
var paper3 = false
var done = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area1.hint1.connect(check.bind("1"))
	area2.hint2.connect(check.bind("2"))
	area3.hint3.connect(check.bind("3"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check(hint):
	match hint:
		"1":
			paper1 = true
		"2":
			paper2 = true
		"3":
			paper3 = true
	
	if paper1 and paper2 and paper3 == true:
		_open()
		
func _open():
	$background/door/closed.visible = false
	$background/door/opened.visible = true
	done = true
	

func next_level() -> void:
	if done == true:
		get_tree().change_scene_to_file("res://scene/level_3.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		next_level()
