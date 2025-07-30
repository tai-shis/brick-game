extends Node2D

var speed = 700
var brick_direction

func _process(delta):
	position -= brick_direction * speed * delta
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
