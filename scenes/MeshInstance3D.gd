extends MeshInstance3D


func _on_SignPost_body_entered(body: Node) -> void:
	if body is KinematicBody:
		# Display a message or perform any other action
		print("Welcome to the sign post! Press a key to interact.")

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		# Handle the interaction, e.g., display more information or trigger an action
		print("You interacted with the sign post!")
