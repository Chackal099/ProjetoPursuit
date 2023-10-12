extends State

class_name AirState

@export var ground_state : State
@export var running_state : State

func state_process(delta):
	if(character.is_on_floor()):
		next_state = ground_state
	if(Input.is_action_pressed("run")):
		next_state = running_state
