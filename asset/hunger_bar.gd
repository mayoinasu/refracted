extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = GlobalScript.max_value
	value = GlobalScript.current_value
	GlobalScript.value_changed.connect(_on_value_changed)

func _on_value_changed(new_value):
	value = new_value
