extends CharacterBody2D


@export var WalkSpeed : float = 100.0
@export var CrouchSpeed : float = 50.0
@export var RunSpeed : float = 200.0
@export var jump_velocity : float = -200.0

#@export var double_jump_velocity : float = -100.0

@onready var animated_sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#var has_double_jumped : bool = false
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
	#else:
		#has_double_jumped = false
		
		
		#if was_in_air == true:
			#land()
			
		was_in_air = false

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			pass
		#elif not has_double_jumped:
			#double_jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	#Dictates the machanics of movement
	if direction.x != 0 && state_machine.check_if_can_move():
		#Walk Mechanics
		velocity.x = direction.x * WalkSpeed
		#Run Mechanics
		if Input.is_action_pressed("run"):
			velocity.x = direction.x * RunSpeed
#			#Slide when running Mechanics
#			if Input.is_action_pressed("crouch"):
#				velocity.x = direction.x * slide_counter
#				if velocity.x != 0:
#					slide_counter -= slide_friction
#				else:
#					velocity.x = direction.x * CrouchSpeed
#			elif Input.is_action_just_released("crouch"):
#				slide_counter = slide_standard
#		elif Input.is_action_pressed("crouch"):
#			velocity.x = direction.x * CrouchSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, WalkSpeed)
	
	update_animation()
	move_and_slide()
	update_facing_direction()
	showVel()
	
func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)
	
#	if not animation_locked:
#		if not is_on_floor():
#			animated_sprite.play("JumpLoop")
#		else:
#			if direction.x != 0 && Input.is_action_pressed("run"):
#				animated_sprite.play("Run")
#				if direction.x != 0 && Input.is_action_pressed("crouch"):
#					animated_sprite.play("Slide")
#				elif direction.x == 0:
#					animated_sprite.play("Crouch")
#			elif direction.x != 0 && Input.is_action_pressed("crouch"):
#				animated_sprite.play("CrouchWalk")
#			elif direction.x != 0:
#				animated_sprite.play("Walk")
#
#			else:
#				animated_sprite.play("Idle")
#				if direction.x == 0 && Input.is_action_pressed("crouch"):
#					animated_sprite.play("Crouch")


func update_facing_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
	
#func double_jump():
#	velocity.y = double_jump_velocity
#	animated_sprite.play("JumpDouble")
#	animation_locked = true
#	has_double_jumped = true
	
#func land():
	#animated_sprite.play("JumpEnd")
	#animation_locked = true
	
func showVel():
	print(velocity.x)

#func _on_animated_sprite_2d_animation_finished():
#	if(["JumpStart", "JumpDouble"].has(animated_sprite.animation)):
#		animation_locked = false
