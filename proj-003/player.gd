extends CharacterBody3D

# how fast the player moves in meters per second
@export var speed = 14

# the downward acceleration when in the air, in meters per second squared
@export var fall_acceleration = 75

var mouse_sensitivity := 0.001
var twist_input := 0.0
var pitch_input := 0.0


# Vertical impulse applied to the character upon jumping in meters per second.
@export var jump_impulse = 20

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

var target_velocity = Vector3.ZERO


func _physics_process(delta):
	# we create a local variable to store the input direction
	var direction = Vector3.ZERO
	
	# we check for each move input and update the direction accordingly
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		# notice how we are working with the vector's x and z axes.
		# in 3D, the XZ plane is the ground plane
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		# Setting the basis property will affect the rotation of the node
		$Pivot.basis = Basis.looking_at($TwistPivot.basis.z) # Basis.looking_at(direction)
		$CollisionShape3D.basis = Basis.looking_at($TwistPivot.basis.z) # Basis.looking_at(direction)
		
	# Ground Velocity
	# target_velocity.x = direction.x * speed
	# target_velocity.z = direction.z * speed
	
	
	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		
	# Moving the Character
	velocity = target_velocity + direction.x * $TwistPivot.basis.x * speed + direction.z * $TwistPivot.basis.z * speed
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse
	move_and_slide()
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.is_action_pressed("look_right"):
		twist_input -= 0.05
	
	if Input.is_action_pressed("look_left"):
		twist_input += 0.05
	
	$TwistPivot.rotate_y(twist_input)
	
	if Input.is_action_pressed("look_up"):
		pitch_input -= 0.05
	
	if Input.is_action_pressed("look_down"):
		pitch_input += 0.05
	
	$TwistPivot/PitchPivot.rotate_x(pitch_input)
	$TwistPivot/PitchPivot.rotation.x = clamp (
		$TwistPivot/PitchPivot.rotation.x,
		-1.5,
		1.5
	)
	twist_input = 0.0
	pitch_input = 0.0
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
