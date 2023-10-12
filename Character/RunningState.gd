extends State

class_name RunningState

@export var ground_state : State
@export var air_state : State
@export var slide_standard : float = 300.0
@export var slide_counter : float = 300.0
@export var slide_friction : float = 5.0
@export var CrouchSpeed : float = 50.0
@export var RunSpeed : float = 200.0

@onready var state_machine : CharacterStateMachine = $/root/TestLevel/player2/CharacterStateMachine

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		ground_state.jump()

	if(event.is_action_pressed("crouch")):
		slide()
		
func slide():
	character.velocity.x = slide_counter
	if character.velocity.x != 0:
		slide_counter -= slide_friction
	else:
		character.velocity.x = character.direction.x * CrouchSpeed
		
func state_process(delta):
	if(Input.is_action_just_pressed("jump")):
		next_state = air_state
	if(Input.is_action_just_released("run")):
		next_state = ground_state
