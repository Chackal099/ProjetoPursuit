extends State

class_name GroundState

@export var air_state : State
@export var running_state : State
@export var RunSpeed : float = 200.0
@export var jump_velocity : float = -150.0

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	elif(event.is_action_pressed("run")):
		sprint()
		
func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	
func sprint():
	character.velocity.x = character.direction.x * RunSpeed
	next_state = running_state
