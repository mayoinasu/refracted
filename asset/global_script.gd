extends Node

signal value_changed(new_value)

var current_value = 100
var max_value = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = 5
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	$main_theme.play()
	
func _on_timer_timeout():
	current_value -= 1
	current_value = clamp(current_value, 0, max_value)
	value_changed.emit(current_value)
	if current_value < 50:
		$main_theme.stop()
		$hungry.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
