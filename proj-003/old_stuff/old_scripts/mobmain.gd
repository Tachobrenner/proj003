extends Node

@export var mob_scene: PackedScene


func _on_mob_timer_timeout() -> void:
	# create a new instance of the mob scene
	var mob = mob_scene.instantiate()
	
	# choose a random location along the SpawnPath
	# we store the reference to the SpawnLocation node
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	# and give it a random offset
	mob_spawn_location.progress_ratio = randf()
	
	var player_position = $Player.position
	mob.initialize(mob_spawn_location.position, player_position)
	
	# spawn the mob by adding it to the main scene
	add_child(mob)
