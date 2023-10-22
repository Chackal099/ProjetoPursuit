extends State

class_name AirState

@export var ground_state : State
@export var running_state : State
@export var sprint_animation : String = "sprint"

var was_in_air : bool = false

func _physics_process(delta):
	if (was_in_air == true):
		character.velocity.y = 0

func state_process(delta):
	if(character.is_on_floor()):
		next_state = ground_state
	if(Input.is_action_pressed("run")):
		playback.travel(sprint_animation)
		next_state = running_state
