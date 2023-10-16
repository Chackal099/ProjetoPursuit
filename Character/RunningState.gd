extends State

class_name RunningState

@export var ground_state : State
@export var air_state : State
@export var slide_standard : float = 300.0
@export var slide_counter : float = 300.0
@export var slide_friction : float = 5.0

@export var move_animation : String = "move"
@export var slide_animation : String = "slide"
@export var duckwalk_animation : String = "duckwalk"


@onready var state_machine : CharacterStateMachine = $/root/TestLevel/player2/CharacterStateMachine


func _physics_process(delta):
	if character.direction.x != 0 && state_machine.check_if_can_move() && state_machine.current_state != ground_state:
	#Run Mechanics
		character.velocity.x = character.direction.x * character.RunSpeed


	if(Input.is_action_pressed("crouch") && state_machine.current_state != ground_state):
		slide()
	elif (Input.is_action_just_released("crouch")):
		slide_counter = slide_standard



func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		ground_state.jump()

func slide():
	playback.travel(slide_animation)
	character.velocity.x = character.direction.x * slide_counter
	if character.velocity.x != 0:
		slide_counter -= slide_friction
	else:
		character.velocity.x = character.direction.x * character.CrouchSpeed
		playback.travel(duckwalk_animation)
		



func state_process(delta):
	if(Input.is_action_just_pressed("jump")):
		next_state = air_state
	if(Input.is_action_just_released("run")):
		playback.travel(move_animation)
		next_state = ground_state
