extends Node2D

var yes = false
var yeah = false

var done1 = false
var done2 = false

var opened = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_unhandled_input(false)


func _process(delta: float) -> void:
	if done1 and done2:
		_open()

func _open():
	$background/door/closed.visible = false
	$background/door/opened.visible = true
	opened = true


func computer_enter(body: Node2D) -> void:
	if body.is_in_group("player"):
		$computer/Label.visible = true
		set_process_unhandled_input(true)
		yes = true


func computer_exit(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"computer/Sprite2D".visible = false
		$"computer/Label2".visible = false
		$"computer/Label3".visible = false
		$"computer/Label".visible = false
		yes = false
		set_process_unhandled_input(false)


func photo_enter(body: Node2D) -> void:
	if body.is_in_group("player"):
		$photo/Label.visible = true
		set_process_unhandled_input(true)
		yeah = true


func photo_exit(body: Node2D) -> void:
	if body.is_in_group("player"):
		$photo/Sprite2D.visible = false
		$"photo/Label3".visible = false
		$"photo/Label".visible = false
		yeah = false
		set_process_unhandled_input(false)
		
func _unhandled_input(event: InputEvent) -> void:
	if yes and event.is_action_pressed("inspect"):
		print("hint1 inspect - in tree?: ", is_inside_tree(), " | path: ", get_path())
		$"computer/Sprite2D".visible = true
		$"computer/Label2".visible = true
		$"computer/Label3".visible = true
		done1 = true
		var vp = get_viewport()
		if vp:
			vp.set_input_as_handled()
		else:
			push_error("hint1 viewport null! path: " + str(get_path()))
	
	if yes and event.is_action_pressed("hide"):
		$"computer/Sprite2D".visible = false
		$"computer/Label2".visible = false
		$"computer/Label3".visible = false
		yes = false
		var vp = get_viewport()
		if vp:
			vp.set_input_as_handled()
			
	if yeah and event.is_action_pressed("inspect"):
		print("hint1 inspect - in tree?: ", is_inside_tree(), " | path: ", get_path())
		$photo/Sprite2D.visible = true
		$"photo/Label3".visible = true
		$"photo/Label".visible = true
		done2 = true
		var vp = get_viewport()
		if vp:
			vp.set_input_as_handled()
		else:
			push_error("hint1 viewport null! path: " + str(get_path()))
	
	if yeah and event.is_action_pressed("hide"):
		$photo/Sprite2D.visible = false
		$"photo/Label3".visible = false
		$"photo/Label".visible = false
		yeah = false
		var vp = get_viewport()
		if vp:
			vp.set_input_as_handled()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		next_level()

func next_level():
	if opened == true:
		get_tree().change_scene_to_file("res://scene/level_6.tscn")
