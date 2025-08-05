extends Node2D

var current_wave: int
@export var gob_scene: PackedScene
@export var war_scene: PackedScene

var starting_nodes: int
var current_nodes: int
var wave_spawn_ended

func _ready():
	current_wave = 0
	Global.current_wave = current_wave
	starting_nodes = get_child_count()
	current_nodes = get_child_count()
	position_to_next_wave()
	
func position_to_next_wave():
	if current_nodes == starting_nodes:
		if current_wave != 0:
			Global.moving_to_next_wave = true
		current_wave += 1
		Global.current_wave = current_wave
		prepare_spawn("Gob", 4.0, 4.0) #start with 4 goblins and mult by 4
		prepare_spawn("War", 2.0, 4.0) # start with 4 warlocks and mult by 2
		print(current_wave)

func prepare_spawn(type, multiplier, mob_spawns):
	var mob_amount = float(current_wave) * multiplier
	var mob_wait_time: float = 2.0
	print("mob_amount: ", mob_amount)
	#spawning enemies in rounds in a wave so 18 goblins dont spawn at once for ex.
	var mob_spawn_rounds = mob_amount/mob_spawns
	spawn_type(type, mob_spawn_rounds, mob_wait_time)
	
func spawn_type(type, mob_spawn_rounds, mob_wait_time):
	if type == "Gob":
		var gob_spawn1 = $GoblinSpawn1
		var gob_spawn2 = $GoblinSpawn2
		var gob_spawn3 = $GoblinSpawn3
		var gob_spawn4 = $GoblinSpawn4
		if mob_spawn_rounds >= 1:
			for i in mob_spawn_rounds:
				var gob1 = gob_scene.instantiate()
				gob1.global_position = gob_spawn1.global_position
				var gob2 = gob_scene.instantiate()
				gob1.global_position = gob_spawn2.global_position
				var gob3 = gob_scene.instantiate()
				gob1.global_position = gob_spawn3.global_position
				var gob4 = gob_scene.instantiate()
				gob1.global_position = gob_spawn4.global_position
				add_child(gob1)
				add_child(gob2)
				add_child(gob3)
				add_child(gob4)
				mob_spawn_rounds -= 1
				await get_tree().create_timer(mob_wait_time)
		wave_spawn_ended = true
