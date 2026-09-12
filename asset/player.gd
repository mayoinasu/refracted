extends CharacterBody2D

@export var speed = 100
@export var animation_tree = AnimationTree
@export var agent = NavigationAgent2D

var hungry = false
var freeze = false

func get_input():
	if hungry == true:
		speed = 30
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if velocity == Vector2.ZERO:
		pass
		$AnimationTree.get("parameters/playback").travel("stop")
	else:
		$AnimationTree.get("parameters/playback").travel("walk")
		$AnimationTree.set("parameters/stop/blend_position", velocity)
		$AnimationTree.set("parameters/walk/blend_position", velocity)
	

func _physics_process(delta):
	get_input()
	move_and_slide()
