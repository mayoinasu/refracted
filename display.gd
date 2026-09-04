extends CanvasLayer

@onready var display: TextureRect = $Display

func _ready() -> void:
	visible = false

func show_closeup(texture: Texture2D) -> void:
	display.texture = texture
	visible = true

func hide_closeup() -> void:
	visible = false
