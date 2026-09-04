extends Node2D

@onready var target: StaticBody2D = $"../censor"

var inside = false

signal finish

func _ready():
	target.activated.connect(_on_target_activated)
	target.deactivated.connect(_on_target_deactivated)
	if inside == true:
		print("success")
		finish.emit()

func _on_target_activated():
	open_door()

func _on_target_deactivated():
	close_door()
	
func open_door():
	$opened.visible = true
	$closed.visible = false
	inside = true
	
func close_door():
	$opened.visible = false
	$closed.visible = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if inside == true:
		if body.is_in_group("player"):
			print("Player masuk area")
