extends CharacterBody2D
@export var speed = 400
const back_dash_speed = 800
var dash_time = 1
var total_time = 0.0
var back_pressed = 0

@onready var brick_scene = preload("res://Scenes/Brick.tscn")

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed

func _physics_process(_delta):
	get_input()
	if Input.is_action_just_pressed("Shoot"):
		throw()
	
	if Input.is_action_just_pressed("Space"):
		
		if Input.is_action_pressed("Left"):
			var x = -50
			var y = 0
			dash_roll(x, y)
		elif Input.is_action_pressed("Right"):
			var x = 50
			var y = 0
			dash_roll(x, y)
		elif Input.is_action_pressed("Up"):
			var x = 0
			var y = -50
			dash_roll(x, y)
		else:
			var x = 0
			var y = 50
			dash_roll(x, y)
				
	move_and_slide()

func dash_roll(x , y):
	var dash_vector = Vector2(x, y)
	move_and_collide(dash_vector)
	
func throw():
	var brick = brick_scene.instantiate()
	brick.position = position
	
	brick.brick_direction = (position - get_global_mouse_position()).normalized()
	
	get_parent().add_child(brick)
