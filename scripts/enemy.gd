class_name Enemy
extends CharacterBody2D

@onready var collision_shape = $CollisionShape2D
var speed = 0
const JUMP_VELOCITY = -400.0

func _ready():

	pass

func _process(delta):

	var direction = Vector2(-1, 0)  
	velocity = direction * speed  
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
