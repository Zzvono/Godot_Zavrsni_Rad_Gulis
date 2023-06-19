extends Node3D

@onready var camera_3d = $Camera3D
@onready var camcollider = $camcollider

func _process(delta):
	if camcollider.is_colliding():
		camera_3d.global_transform.origin = lerp(camera_3d.global_transform.origin, camcollider.get_collision_point(), 0.2)
	else:
		camera_3d.global_transform.origin = $neki.global_transform.origin
