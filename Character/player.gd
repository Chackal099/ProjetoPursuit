extends CharacterBody2D


@export var speed : float = 200.0
@export var jump_velocity : float = -150.0
@export var double_jump_velocity : float = -100.0

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var stateMachine : CharacterStateMachine = $CharacterStateMachine


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_double_jumped : bool = false
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false

func _ready():
	animation_tree.active = true


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		was_in_air = true
	else:
		has_double_jumped = false
		
		
		if was_in_air == true:
			land()
			
		was_in_air = false

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			jump()
		elif not has_double_jumped:
			double_jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x != 0 && stateMachine.checkIfCanMove():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation()
	update_facing_direction()
	
func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)
#
#	if not animation_locked:
#		if not is_on_floor():
#			animated_sprite.play("JumpLoop")
#		else:
#			if direction.x != 0:
#				animated_sprite.play("Run")
#			else:
#				animated_sprite.play("Idle")

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true

func jump():
	velocity.y = jump_velocity
#	animated_sprite.play("JumpStart")
	animation_locked = true
	
func double_jump():
	velocity.y = double_jump_velocity
#	animated_sprite.play("JumpDouble")
	animation_locked = true
	has_double_jumped = true
	
func land():
#	animated_sprite.play("JumpEnd")
	animation_locked = true


#func _on_animated_sprite_2d_animation_finished():
#	if(["JumpEnd", "JumpStart", "JumpDouble"].has(animated_sprite.animation)):
#		animation_locked = false
