extends Area2D

signal info22
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_unhandled_input(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"../Label".visible = true
		set_process_unhandled_input(true)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"../Sprite2D".visible = false
		$"../Label2".visible = false
		$"../Label3".visible = false
		$"../Label".visible = false
		set_process_unhandled_input(false)
		
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inspect"):
		print("hint1 inspect - in tree?: ", is_inside_tree(), " | path: ", get_path())
		info22.emit()
		$"../Sprite2D".visible = true
		$"../Label2".visible = true
		$"../Label3".visible = true
		var vp = get_viewport()
		if vp:
			vp.set_input_as_handled()
		else:
			push_error("hint1 viewport null! path: " + str(get_path()))
	
	if event.is_action_pressed("hide"):
		$"../Sprite2D".visible = false
		$"../Label2".visible = false
		$"../Label3".visible = false
		var vp = get_viewport()
		if vp:
			vp.set_input_as_handled()
