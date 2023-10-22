extends Camera2D

var camera_speed = 100  # Adjust this value to control camera speed
var character : Node2D  # Reference to your character node

func _ready():
	character = $/root/TestLevel/player2  # Replace with the actual path to your character node

func _process(delta):
	# Get the mouse position relative to the viewport
	var mouse_position = get_viewport().get_mouse_position()

	# Calculate the camera's new position based on the mouse position
	var new_camera_position = position + (mouse_position - get_viewport_rect().size / 2) * delta * camera_speed

	# Calculate the camera's offset to keep the character in view
	var camera_offset = get_viewport_rect().size / 2
	var character_position = character.global_position
	var max_x = character_position.x + camera_offset.x
	var min_x = character_position.x - camera_offset.x
	var max_y = character_position.y + camera_offset.y
	var min_y = character_position.y - camera_offset.y

	# Clamp the camera's position to keep the character in view
	new_camera_position.x = clamp(new_camera_position.x, min_x, max_x)
	new_camera_position.y = clamp(new_camera_position.y, min_y, max_y)

	# Update the camera's position
	position = new_camera_position
