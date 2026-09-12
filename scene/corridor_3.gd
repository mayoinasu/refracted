extends Node2D

@onready var food_check = $food/Area2D
@onready var info1 = $info1/Area2D
@onready var info2 = $info2/Area2Dw

var crit1 = false
var crit2 = false
var crit3 = false

var done = true

func _ready() -> void:
	food_check.food.connect(check.bind("1"))
	info1.info1.connect(check.bind("2"))
	set_process_unhandled_input(false)

func _process(delta: float) -> void:
	pass
	
func check(hint):
	match hint:
		"1":
			crit1 = true
			print("aman1")
		"2":
			crit2 = true
			print("aman2")
		"3":
			crit3 = true
			print("aman3")
	
	if crit1 and crit2 and crit3:
		_open()
		
func _open():
	$background/door/closed.visible = false
	$background/door/opened.visible = true
	done = true

func next_level() -> void:
	if done == true:
		get_tree().change_scene_to_file("res://scene/level_4.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$info2/Label.visible = true
		set_process_unhandled_input(true)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"info2/Sprite2D".visible = false
		$"info2/Label2".visible = false
		$"info2/Label3".visible = false
		$"info2/Label".visible = false
		set_process_unhandled_input(false)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inspect"):
		_open()
		print("hint1 inspect - in tree?: ", is_inside_tree(), " | path: ", get_path())
		$"info2/Sprite2D".visible = true
		$"info2/Label2".visible = true
		$"info2/Label3".visible = true
		var vp = get_viewport()
		if vp:
			vp.set_input_as_handled()
		else:
			push_error("hint1 viewport null! path: " + str(get_path()))
	
	if event.is_action_pressed("hide"):
		$"info2/Sprite2D".visible = false
		$"info2/Label2".visible = false
		$"info2/Label3".visible = false
		var vp = get_viewport()
		if vp:
			vp.set_input_as_handled()


func door_skip(body: Node2D) -> void:
	if body.is_in_group("player"):
		next_level()
