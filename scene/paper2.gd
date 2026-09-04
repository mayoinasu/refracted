extends Area2D

signal hint2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process_unhandled_input(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inspect"):
		print("hint2 inspect - in tree?: ", is_inside_tree(), " | path: ", get_path())
		hint2.emit()
		$"../Sprite2D2".visible = true
		$"../Label22".visible = true
		$"../Label32".visible = true
		var vp = get_viewport()
		if vp:
			vp.set_input_as_handled()
		else:
			push_error("hint2 viewport null! path: " + str(get_path()))
	
	if event.is_action_pressed("hide"):
		$"../Sprite2D2".visible = false
		$"../Label22".visible = false
		$"../Label32".visible = false
		var vp = get_viewport()
		if vp:
			vp.set_input_as_handled()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$Label.visible = true
		set_process_unhandled_input(true)


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$"../Sprite2D2".visible = false
		$"../Label22".visible = false
		$"../Label32".visible = false
		$Label.visible = false
		set_process_unhandled_input(false) 
