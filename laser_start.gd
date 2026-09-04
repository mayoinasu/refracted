extends Node2D

@onready var lasers: Node2D = $lasers
@export var laser_texture: Texture2D
@export_flags_2d_physics var laser_collision_mask: int = 1

var laserStartDirection = Vector2.UP
var length = 8000
var _currentTarget: Node = null   # <-- BARU: nyimpen target yang lagi kena laser ini

func _ready() -> void:
	add_to_group("laser")
	refresh_laser()

func refresh_laser():
	for child in lasers.get_children():
		child.queue_free()
		
	_set_laser()

func _set_laser():
	var currentPoint = global_position
	var targetPoint = currentPoint + length * laserStartDirection
	var nextTarget = _ray_cast(currentPoint, targetPoint, self)
	var direction = laserStartDirection
	var hitTargetThisPass = null   # <-- BARU

	while nextTarget:
		var reflectDirection
		var nextPoint
		
		if nextTarget.collider.has_method("get_reflect_direction"):
			reflectDirection = nextTarget.collider.get_reflect_direction(direction)
		
		if reflectDirection:
			direction = reflectDirection
			_add_laser(currentPoint, nextTarget.collider.global_position)
			nextPoint = nextTarget.collider.global_position
		else:
			_add_laser(currentPoint, nextTarget.position)
			nextPoint = nextTarget.position

			# BARU: kalau collider ini Target, tandai kena di pass ini
			if nextTarget.collider.is_in_group("laser_target"):
				hitTargetThisPass = nextTarget.collider
			break
			
		currentPoint = nextPoint
		targetPoint = currentPoint + length * direction
		nextTarget = _ray_cast(currentPoint, targetPoint, nextTarget.collider)

	_update_target_state(hitTargetThisPass)   # <-- BARU

func _update_target_state(newTarget) -> void:
	if newTarget == _currentTarget:
		return
	if _currentTarget:
		_currentTarget.laser_unhit()
	if newTarget:
		newTarget.laser_hit()
	_currentTarget = newTarget

func _ray_cast(startPoint, targetPoint, excluded):
	var space_state = get_world_2d().direct_space_state
	var params = PhysicsRayQueryParameters2D.new()
	params.from = startPoint
	params.to = targetPoint
	params.exclude = [excluded]
	
	return space_state.intersect_ray(params)

func _add_laser(startPoint, endPoint):
	var line = Line2D.new()
	line.add_point(Vector2(0,0))
	line.add_point(endPoint- startPoint)
	line.width = 8
	line.texture = laser_texture
	line.texture_mode = Line2D.LINE_TEXTURE_TILE
	
	lasers.add_child(line)
	
	line.global_position = startPoint
