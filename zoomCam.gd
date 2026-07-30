extends Camera3D

@export var zoomedIn = false
@export var zoomFOV = 15.0
@export var baseFOV = 75.9

func _process(delta: float) -> void :
	if Input.is_action_pressed("Zoom") :
		fov = lerp(fov,zoomFOV,0.5)
	else :
		fov = lerp(fov,baseFOV,0.8)
