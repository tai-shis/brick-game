extends CharacterBody2D

@export var is_player = false
@export var is_projectile = false

var health = 100
var speed = 500
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		position += (player.position - position)/speed
		move_and_slide()
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false

func _on_hitbox_body_entered(body: Node2D) -> void:
	print('hitbox detected')
	if body.is_projectile == true:
		health -= body.damage
		print(health)
		if health <= 0:
			queue_free()
