extends CharacterBody3D

@export var speed = 5.0
@export var jumpVel = 4.5
signal coords(pos)

var mouseLock = true

func _ready() -> void :
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event) -> void :
	if event is InputEventMouseMotion and mouseLock:
		var look : Vector2 = event.screen_relative
		var look3 = Vector3(look.x/-100,0,look.y/-100) + rotation
		global_rotate(Vector3(0,1,0),look.x/-100)
		rotate_object_local(Vector3(1,0,0),look.y/-100)
		#print(look3,"-", rotation)
	elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE) :
		var look : Vector2 = event.screen_relative
		var look3 = Vector3(look.x/-100,0,look.y/-100) + rotation
		global_rotate(Vector3(0,1,0),look.x/-100)
		rotate_object_local(Vector3(1,0,0),look.y/-100)
		#print(look,"-", rotation)
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and mouseLock == false :
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif Input.mouse_mode == Input.MOUSE_MODE_VISIBLE and mouseLock == true :
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("Mouse control") :
		if mouseLock :
			mouseLock = false
		else :
			mouseLock = true


func _physics_process(delta: float) -> void :
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y = jumpVel

	# Get the input direction and handle the movement/deceleration.
	var inputDir := Input.get_vector("Left", "Right", "Forward", "Back")
	var direction := (transform.basis * Vector3(inputDir.x, 0, inputDir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	#print(direction, "-", velocity)
	coords.emit(position)
	move_and_slide()
