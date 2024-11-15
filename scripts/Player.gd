extends CharacterBody2D

signal jumped

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var audio_stream_player = $AudioStreamPlayer2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Move Left", "Move Right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().get_script() != null:
			print("I collided with ", collision.get_collider().name, " ", collision.get_collider().get_script().get_global_name())
	
func jump():
	velocity.y = JUMP_VELOCITY
	audio_stream_player.play_track(0)
