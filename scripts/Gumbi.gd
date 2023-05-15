extends Button


func _on_playButton_pressed():
	get_tree().change_scene_to_file("res://scenes/World.tscn")


func _on_quit_pressed():
	get_tree().quit()
