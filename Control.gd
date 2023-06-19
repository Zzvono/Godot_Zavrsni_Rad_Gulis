extends Control

func _ready():
	$AnimationPlayer.play("text animation")
	
func _on_fight_1_pressed():
	get_tree().change_scene_to_file("res://scenes/battle_stingray.tscn")


func _on_w_1_pressed():
	get_tree().change_scene_to_file("res://scenes/World.tscn")


func _on_w_2_pressed():
	get_tree().change_scene_to_file("res://scenes/World2.tscn")


func _on_w_3_pressed():
	get_tree().change_scene_to_file("res://scenes/World3.tscn")


func _on_f_2_pressed():
	get_tree().change_scene_to_file("res://scenes/battle_Imp.tscn")


func _on_f_3_pressed():
	get_tree().change_scene_to_file("res://scenes/battle_Skeleton.tscn")
