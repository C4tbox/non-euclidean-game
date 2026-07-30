extends Camera3D

var cameraLockMouse = true

func _ready() -> void :
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event) -> void :
	if event is InputEventMouseMotion and cameraLockMouse :
		var look : Vector2 = event.screen_relative
		var look3 = Vector3(look.x/-100,0,look.y/-100) + rotation
		global_rotate(Vector3(0,1,0),look.x/-100)
		rotate_object_local(Vector3(1,0,0),look.y/-100)
		print(look3,"-", rotation)
