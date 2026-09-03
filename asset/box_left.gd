extends StaticBody2D
var position_box = 384

@export var rotation_step_degrees := 45.0

func _ready():
	$"../Sprite2D".region_enabled = true
	add_to_group("mirror")

func rotate_box():
	rotation_degrees = wrapf(rotation_degrees + rotation_step_degrees, 0, 360)
	print(rotation_degrees)

func _input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("click"):
		rotate_box()
		
		if position_box == 0:
			position_box = 384
		else:
			position_box -= 128
		print(position_box)
		$"../Sprite2D".region_rect = Rect2(position_box, 0, 64, 100)
