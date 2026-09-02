extends Node2D

@export var laser_source: Node2D
@export var max_bounce := 12
@export var max_distance := 3000.0
@export var laser_texture: Texture2D
@onready var container := $Node2D

signal target_hit

func _physics_process(delta: float) -> void:
	cast_laser()

func _on_laser_hit_target():
	emit_signal("target_hit")
	

func cast_laser():
	#print("laser_source name: ", laser_source.name, " | pos: ", laser_source.global_position, " | rot: ", laser_source.global_rotation)
	#if laser_source == null:
		#print("ERROR: laser_source kosong!")
		#return
	#if laser_texture == null:
		#print("ERROR: laser_texture kosong!")


	var space_state = get_world_2d().direct_space_state
	#print("mulai cast dari: ", laser_source.global_position)
	#var location_x = laser_source.global_position
	var points = [laser_source.global_position]
	var current_pos = laser_source.global_position
	var current_dir = Vector2.RIGHT.rotated(laser_source.global_rotation)
	
	for i in range (max_bounce):
		var query = PhysicsRayQueryParameters2D.create(
			current_pos, current_pos + current_dir*max_distance
		)
		
		query.exclude = [laser_source]
		var result = space_state.intersect_ray(query)
		#print("hasil raycast ke-", i, ": ", result)
		
		if result.is_empty():
			points.append(current_pos + current_dir*max_distance)
			break
			
		points.append(result.position)
		
		if result.collider.is_in_group("mirror"):
			#print("Hit: ", result.collider.name)
			#print("Normal: ", result.normal)
			#print("Dir before: ", current_dir)
			
			current_dir = current_dir.bounce(result.normal)
			current_pos = result.position+ current_dir* 0.5
			
		elif result.collider.is_in_group("target"):
			_on_laser_hit_target()
			break
		else:
			break
		
	_draw_laser(points)
			
func _draw_laser(points: Array):
	for child in container.get_children():
		child.queue_free()
	
	for i in range(points.size() - 1):
		var start = points[i]
		var end = points[i+1]
		var vec = end - start
		
		var seg = Sprite2D.new()
		seg.texture = laser_texture
		seg.centered = true
		seg.global_position = start + vec*0.5
		seg.global_rotation = vec.angle()
		seg.scale.x = vec.length() / laser_texture.get_width()
		container.add_child(seg)
		
			
			
