extends StaticBody3D


func _on_Player_body_entered(body):
	if body.name == "Player": 	get_tree().change_scene_to_file("res://scenes/battle.tscn")     
