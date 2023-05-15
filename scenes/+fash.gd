extends CharacterBody3D


const SPEED = 7.0


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var animation_player: AnimationPlayer

enum AnimationState {
	IDLE,
	FORWARD,
	BACKWARD,
	LEFT,
	RIGHT
}
var current_animation_state: AnimationState = AnimationState.IDLE

func _ready() -> void:
	# Assuming you have an AnimationPlayer node in the scene
	animation_player = get_node("AnimationPlayer")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_down", "ui_up", "ui_left", "ui_right")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	var h_movement: Vector3 = Vector3.ZERO

	if input_dir.y > 0.0:
		h_movement += -transform.basis.z * SPEED * delta
		current_animation_state = AnimationState.FORWARD
	elif input_dir.y < 0.0:
		h_movement += transform.basis.z * SPEED * delta
		current_animation_state = AnimationState.BACKWARD

	if input_dir.x > 0.0:
		h_movement += transform.basis.x * SPEED * delta
		current_animation_state = AnimationState.RIGHT
	elif input_dir.x < 0.0:
		h_movement += -transform.basis.x * SPEED * delta
		current_animation_state = AnimationState.LEFT

	move_and_slide()
	update_animation()

func update_animation() -> void:
	var animation_name: String
	if velocity.length() < 0.01:
		current_animation_state = AnimationState.IDLE
	match current_animation_state:
		AnimationState.IDLE:
			animation_name = "Idle_metarig"
		AnimationState.FORWARD:
			animation_name = "Walking"
		AnimationState.BACKWARD:
			animation_name = "Walking"
		AnimationState.LEFT:
			animation_name = "Walking"
		AnimationState.RIGHT:
			animation_name = "Walking"

	if animation_name != "":
		animation_player.play(animation_name)
