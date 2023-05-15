extends Control

@onready var Target_XZ = get_parent().get_node("mothman")
@onready var Target_Y = get_parent().get_node("Terrain/Smooth2")
@onready var cam = get_node("MapContainer/MapViewport/Camera3D")

func _physics_process(delta):
	var Target_XZ_pos = Target_XZ.global_transform.origin
	var cam_pos = cam.global_transform.origin
	var a = Target_XZ.to_local(cam_pos) - Target_XZ_pos
	var Target_Y_pos = Target_Y.global_transform.origin
	var b = Target_Y.to_local(cam_pos) - Target_Y_pos
	var x_translation = Vector3(a.x, b.y+40, a.z)
	cam.translate(x_translation)
	"""
	cam.translation.x = Target_XZ.get_global_transform().origin.x
	cam.translation.z = Target_XZ.get_global_transform().origin.z
	cam.translation.y = Target_Y.get_global_transform().origin.y + 40.0
	"""
	

