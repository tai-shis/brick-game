extends Node2D

var speed = 700
var brick_direction

func _process(delta):
	position -= brick_direction * speed * delta
	pass
