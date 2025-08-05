extends CharacterBody2D

@export var speed = 400
@export var is_player = true
@export var is_projectile = false

var experience = 0

const dash_dist = 50

@onready var brick_scene = preload("res://Scenes/Brick.tscn")

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	return input_direction 

func _physics_process(_delta):
	velocity = get_input() * speed
	if Input.is_action_just_pressed("Shoot"):
		throw()
	
	if Input.is_action_just_pressed("Space"):
		var multiples = velocity.normalized()
		dash_roll(multiples.x * dash_dist, multiples.y * dash_dist)
				
	move_and_slide()

func dash_roll(x , y):
	var dash_vector = Vector2(x, y)
	move_and_collide(dash_vector)
	
func throw():
	var brick = brick_scene.instantiate()
	brick.position = position
	brick.source = self
	
	brick.brick_direction = (position - get_global_mouse_position()).normalized()
	
	get_parent().add_child(brick)
