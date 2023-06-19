extends Area3D


func _input(event):
	if len(get_overlapping_bodies())>3:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().change_scene_to_file("res://scenes/battle_Imp.tscn")
