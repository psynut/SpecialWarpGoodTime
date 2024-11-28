class_name Enemy
extends CharacterBody2D

@onready var collision_shape = $CollisionShape2D
var speed = 0
const JUMP_VELOCITY = -400.0

var facing_right = true

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
	velocity.x = speed  
	if velocity.x <0 && facing_right:
		scale.x = 0-scale.x
		facing_right = false
	elif velocity.x>0 && !facing_right:
		scale.x = 0-scale.x
		facing_right = true
	move_enemy()

func move_enemy():
	
	move_and_slide()

	var collision = get_slide_collision(0)
	if collision:
		var collider = collision.get_collider()
		if collider:
			#print("Collided with: ", collider.name)

			if collider is CharacterBody2D and collider.name == "Player":
				if collider.has_method("player_hurt"):
					collider.player_hurt(global_position)
				else:
					print("The player does not have the method 'player_hurt'")

func jump():
	velocity.y = JUMP_VELOCITY
	#audio_stream_player.play()
	#animation_player.play("Jump")
	#is_jumping = true
