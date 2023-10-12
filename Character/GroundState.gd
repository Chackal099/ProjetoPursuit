extends State

class_name GroundState

@export var air_state : State
@export var running_state : State
@export var WalkSpeed : float = 100.0

@onready var state_machine : CharacterStateMachine = $/root/TestLevel/player2/CharacterStateMachine


func state_input(event : InputEvent):
	
	if(event.is_action_pressed("jump")):
		jump()
	elif(event.is_action_pressed("run")):
		sprint()
		
func jump():
	character.velocity.y = character.jump_velocity
	next_state = air_state
	
func sprint():
	next_state = running_state
