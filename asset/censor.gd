extends StaticBody2D

signal activated
signal deactivated

var hit_count: int = 0

func _ready() -> void:
	add_to_group("laser_target")

func laser_hit() -> void:
	hit_count += 1
	if hit_count == 1:
		print ("done")
		activated.emit()
		_on_activated()
		$on.visible = true

func laser_unhit() -> void:
	hit_count = max(hit_count - 1, 0)
	if hit_count == 0:
		deactivated.emit()
		_on_deactivated()

func is_active() -> bool:
	return hit_count > 0

func _on_activated() -> void:
	$on.visible = true
	$off.visible = false

func _on_deactivated() -> void:
	$on.visible = false
	$off.visible = true
