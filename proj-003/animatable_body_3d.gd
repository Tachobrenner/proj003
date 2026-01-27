extends AnimatableBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _process(_delta) -> void:
	self.rotate_y(0.02)
