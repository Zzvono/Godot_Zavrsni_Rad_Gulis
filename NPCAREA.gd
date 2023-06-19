extends Area3D


func _input(event):
	if event.is_action_pressed("Help") and len(get_overlapping_bodies())>2:
		use_dialogue()

func use_dialogue():
	var dialogue = get_parent().get_node("TextBox_prvi")
	
	if dialogue:
		dialogue.start()
