extends CharacterBody2D

@export var damage = 10
@export var is_player = false
@export var is_projectile = true

var speed = 700
var brick_direction

func _process(delta):
	position -= brick_direction * speed * delta
	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_collision_body_entered(body: Node2D) -> void:
	if body.is_player == false:
		queue_free()
