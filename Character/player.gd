extends CharacterBody2D


@export var WalkSpeed : float = 100.0
@export var CrouchSpeed : float = 50.0
@export var RunSpeed : float = 200.0
@export var jump_velocity : float = -200.0

@onready var animated_sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false


func _ready():
	animation_tree.active = true
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	
	update_animation()
	move_and_slide()
	update_facing_direction()
	showVel()
	
func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)
	

func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true

func showVel():
	print(velocity.x)
