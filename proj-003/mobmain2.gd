extends Node

@export var mob_scene: PackedScene
@export var a := Vector3.ZERO
@export var b := Vector3.ZERO

func _on_mob_timer_timeout():
	# create a new instance of the mob scene
	
	var mob = mob_scene.instantiate()
	
	await get_tree().create_timer(1.0).timeout
	# choose a random location along the SpawnPath
	# we store the reference to the SpawnLocation node
	mob.global_position = a
	mob.settem(a ,b)
	
	# spawn the mob by adding it to the main scene
	add_child(mob)
