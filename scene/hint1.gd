extends Area2D

@export var closeup_texture: Texture2D
@onready var closeup_display: CanvasLayer =  $"../display" # sesuaikan path

var player_inside: bool = false
signal read

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	set_process_unhandled_input(false)  # matiin listen input dulu di awal

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = true
		set_process_unhandled_input(true)
		# opsional: munculin prompt "Tekan E buat lihat"
		# $PromptLabel.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_inside = false
		set_process_unhandled_input(false)
		# $PromptLabel.visible = false
		closeup_display.hide_closeup()  # opsional: auto-close kalau player kabur

func _unhandled_input(event: InputEvent) -> void:
	if player_inside and event.is_action_pressed("inspect"):
		closeup_display.show_closeup(closeup_texture)
		get_viewport().set_input_as_handled()
		read.emit()
	if player_inside and event.is_action_pressed("hide"):
		closeup_display.hide_closeup()
