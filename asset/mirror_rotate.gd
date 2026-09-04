extends StaticBody2D

var position_box = 512

enum REFLECT_DIRECTION {NW, NE, SE, SW}

var reflectionDirection: REFLECT_DIRECTION = REFLECT_DIRECTION.NE

func get_reflect_direction(impactDirection):
	var possibleDirections = _get_possible_directions()

	if -impactDirection in possibleDirections:
		possibleDirections.erase(-impactDirection)
		return possibleDirections[0]
		
func _get_possible_directions():
	match reflectionDirection:
		REFLECT_DIRECTION.NW: return [Vector2.UP, Vector2.LEFT]
		REFLECT_DIRECTION.NE: return [Vector2.UP, Vector2.RIGHT]
		REFLECT_DIRECTION.SW: return [Vector2.DOWN, Vector2.LEFT]
		REFLECT_DIRECTION.SE: return [Vector2.DOWN, Vector2.RIGHT]


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		rotate(deg_to_rad(90))
		reflectionDirection += 1
		if position_box == 0:
			position_box = 384
		else:
			position_box -= 128
		print(position_box)
		$"../Sprite2D".region_rect = Rect2(position_box, 0, 64, 100)

		if reflectionDirection == REFLECT_DIRECTION.keys().size():
			reflectionDirection = 0

		var laser = get_tree().get_first_node_in_group("laser")
		laser.refresh_laser()
