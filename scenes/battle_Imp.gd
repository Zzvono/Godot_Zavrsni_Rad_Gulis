extends Control

signal textbox_closed

@export var Enemy: Resource = null

var current_player_health = 0
var current_enemy_health = 0
var is_defending = false


func _ready():
	set_health($EnemyHealth, Enemy.health, Enemy.health)
	set_health($PlayerPanel/PlayerData/ProgressBar, State.current_health, State.max_health)
	$Enemy.texture = Enemy.texture
	
	current_player_health = State.current_health
	current_enemy_health = Enemy.health
	
	$TextBox.hide()
	$Actions.hide()
	
	display_text("You attack a wild %s !" % Enemy.name)
	$Battlecry.play()
	

func set_health(progress_bar,health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d" % [health,max_health]
	
func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $TextBox.visible:
		$TextBox.hide()
		emit_signal("textbox_closed")
		$Actions.show()
	
func display_text(text):
	$TextBox.show()
	$TextBox/Label.text = text

func enemy_turn():
	display_text("%s attacks!" % Enemy.name)
	await get_tree().create_timer(1).timeout
	
	if is_defending:
		is_defending = false
		$Actions.hide()
		$AnimationPlayer.play("Enemy_attack_shield")
		$Attacking_s.play()
		await get_tree().create_timer(1).timeout
		$AnimationPlayer.play("Enemy_idle")
		display_text("You blocked the attack!")
		await get_tree().create_timer(1).timeout
		display_text("Your turn!")
		$Actions.show()
		
		
	else :
		$Actions.hide()
		current_player_health -= Enemy.damage
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
		$AnimationPlayer.play("Enemy_attack")
		$Attacking.play()
		$PlayerHit.play()
		await get_tree().create_timer(1).timeout
		$AnimationPlayer.play("Enemy_idle")
		display_text("%s delt %d damage!" % [Enemy.name, Enemy.damage])
		display_text("Your turn!")
		$Actions.show()
	
	if current_player_health <=0:
		$Actions.hide()
		display_text("You died!")
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://scenes/Title screen.tscn")

func _on_run_pressed():
	$Actions.hide()
	display_text("You abandoned your mission!")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://scenes/World2.tscn")
	


func _on_attack_pressed():
	$Actions.hide()
	display_text("You punch the %s as hard as you can!" % Enemy.name)
	await get_tree().create_timer(1).timeout
	$Punch.play()
	$GettingHit.play()
	current_enemy_health -= State.damage
	set_health($EnemyHealth, current_enemy_health, Enemy.health)
	$AnimationPlayer.play("Enemy_Damaged")
	await get_tree().create_timer(1).timeout
	display_text("You delt %d damage!" % State.damage)
	$Actions.show()
	
	if current_enemy_health <= 0:
		$Actions.hide()
		$AnimationPlayer.play("Enemy_death")
		$Dying.play()
		$EnemyHealth.hide()
		display_text("You leveled up! +10 Atk +10 Heal")
		await get_tree().create_timer(2).timeout
		State.heal += 40
		State.damage +=10
		get_tree().change_scene_to_file("res://scenes/World3.tscn")
	else:
		enemy_turn()


func _on_defend_pressed():
	$Actions.hide()
	is_defending = true
	display_text("You prepare for the upcoming attack!")
	await get_tree().create_timer(1).timeout
	$Actions.show()
	enemy_turn()


func _on_heal_pressed():
	$Actions.hide()
	$Heal.play()
	if current_player_health <= 100:
		current_player_health += State.heal
		await get_tree().create_timer(1).timeout
		display_text("You've healed yourself for %d health" % State.heal)
	else:
		current_player_health = State.max_health
		await get_tree().create_timer(1).timeout
		display_text("You've healed yourself fully")
	await get_tree().create_timer(1).timeout
	set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
	$Actions.show()
	enemy_turn()
