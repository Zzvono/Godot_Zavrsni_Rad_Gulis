extends CanvasLayer

@onready var textbox_cointainer = $TextboxCointainer
@onready var tekst = $TextboxCointainer/MarginContainer/HBoxContainer/Tekst


enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []
var d_active = false



func _ready():
	print("Starting state to: State.READY")
	hide_textbox()
	queue_text("Finally someone came to help us!")
	queue_text("Please slay the monster that killed all our men.")
	queue_text("It's been stealing our crops for the past week.")
	queue_text("The beast resides East of this town you will find it   easily.")

func start():
	if d_active:
		return
	d_active = true
	
func _process(delta):
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("Help"):
				$AnimationPlayer.stop()
				tekst.visible_ratio = 1
		State.FINISHED:
			if Input.is_action_just_pressed("Help"):
				change_state(State.READY)
				textbox_cointainer.hide()

func queue_text(next_text):
	text_queue.push_back(next_text)


func hide_textbox():
	tekst.text = ""
	textbox_cointainer.hide()

func show_textbox():
	textbox_cointainer.show()

func display_text():
	if d_active:
		var next_text = text_queue.pop_front()
		tekst.text = next_text
		tekst.visible_ratio = 0
		change_state(State.READING)
		show_textbox()
		$AnimationPlayer.play("text animation")
		await get_tree().create_timer(2).timeout
		change_state(State.FINISHED)
		

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")
