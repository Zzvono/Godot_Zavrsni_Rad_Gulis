extends CharacterBody3D
@onready var Camera_mount = $Camera_mount

@export var SPEED = 20.0
@export var sens_horizontal = 0.25
@export var sens_vertical = 0.25

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		Camera_mount.rotate_x(deg_to_rad(event.relative.y * sens_vertical))
	if Input.is_action_just_pressed("dada"):
			$"../UI/Control/TextBox".hide()
			
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var input_dir = Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		$AnimationPlayer.play("metarig|mixamocom|Layer0")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		$AnimationPlayer.play("metarig|metarig|Idle_metarig")
	
	move_and_slide()

