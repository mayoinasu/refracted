extends StaticBody2D
var position_box = 0
func _ready() -> void:
	$Sprite2D.region_enabled = true
	

func _input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("click"):
		if position_box == 448:
			position_box = 0
		else:
			position_box += 64
		$Sprite2D.region_rect = Rect2(position_box, 0, 64, 100)
