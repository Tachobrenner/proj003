extends AnimatableBody3D

@export var a := Vector3()
@export var b := Vector3()
@export var time : float = 2.0
@export var pause : float = 0.7

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func move():
	var move_tween = create_tween()
	for z in 99999:
		move_tween.tween_property(self,"position", b, time)
		move_tween.tween_property(self,"position", a, time)
	#queue_free()
	
func settem(one, two):
	a = one
	b = two
