extends State

class_name GroundState

@export var air_state : State
@export var running_state : State

@onready var state_machine : CharacterStateMachine = $/root/TestLevel/player2/CharacterStateMachine

func _physics_process(delta):
		if character.direction.x != 0 && state_machine.check_if_can_move():
		#Walk Mechanics
			character.velocity.x = character.direction.x * character.WalkSpeed


func state_input(event : InputEvent):
	
	if(event.is_action_pressed("jump")):
		jump()
	elif(event.is_action_pressed("run")):
		sprint()
		

func jump():
	character.velocity.y = character.jump_velocity
	next_state = air_state
	
func sprint():
	character.velocity.x = character.direction.x * character.RunSpeed
	next_state = running_state
