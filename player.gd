extends CharacterBody2D


const SPEED = 500.0
const JUMP_VELOCITY = -400.0

@onready var imagePlayer = get_node("player")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("player jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("player left", "player right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	var vel = move_and_slide()
	if velocity.x<0:
		imagePlayer.flip_h = true
	elif velocity.x>0:
		imagePlayer.flip_h = false
