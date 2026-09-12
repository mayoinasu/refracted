extends Area2D

signal food
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
		$"../Label".visible = false
		set_process_unhandled_input(false) 

func _unhandled_input(event: InputEvent) -> void:
		
	if event.is_action_pressed("eat"):
		food.emit()
		print("hint1 inspect - in tree?: ", is_inside_tree(), " | path: ", get_path())
		$"../Sprite2D".visible = false
		var vp = get_viewport()
		if vp:
			vp.set_input_as_handled()
		else:
			push_error("hint1 viewport null! path: " + str(get_path()))
