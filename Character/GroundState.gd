extends State

class_name GroundState

@export var air_state : State
@export var running_state : State

@export var sprint_animation : String = "sprint"
@export var jump_animation : String = "jump"
@export var duckwalk_animation : String = "duckwalk"
@export var move_animation : String = "move"

@onready var state_machine : CharacterStateMachine = $/root/TestLevel/player2/CharacterStateMachine

var was_in_air : bool = false

func _physics_process(delta):
		if character.direction.x != 0 && state_machine.check_if_can_move() && state_machine.current_state != running_state:
		#Walk Mechanics
			character.velocity.x = character.direction.x * character.WalkSpeed
			if Input.is_action_pressed("crouch"):
				character.velocity.x = character.direction.x * character.CrouchSpeed
				playback.travel(duckwalk_animation)
			elif Input.is_action_just_released("crouch"):
				playback.travel(move_animation)
		else:
			character.velocity.x = move_toward(character.velocity.x, 0, character.WalkSpeed)
			if Input.is_action_just_released("crouch"):
				playback.travel(move_animation)


func state_input(event : InputEvent):
	
	if(event.is_action_pressed("jump")):
		jump()
	elif(event.is_action_pressed("run")):
		sprint()
		

func jump():
	character.velocity.y = character.jump_velocity
	playback.travel(jump_animation)
	was_in_air = true
	next_state = air_state
	
func sprint():
	character.velocity.x = character.direction.x * character.RunSpeed
	playback.travel(sprint_animation)
	next_state = running_state
