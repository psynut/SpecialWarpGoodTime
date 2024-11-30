extends CharacterBody2D

signal jumped

var health = 100
@export var speed = 300.0
@export var jump_velocity = -700
@export var gravity_factor = 3

var original_position : Vector2

@onready var audio_stream_player = $AudioStreamPlayer2D
@onready var animation_player = $AnimationPlayer
@onready var sprites_node = $Sprites
@onready var damage_timer = $"Took Damage Timer"
@onready var particle_systems_node = $ParticleSystems

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var player_controlling = true
var is_jumping = false

func _ready():
	original_position = global_position
	return_home()

func _physics_process(delta):
	if not is_on_floor():
		if velocity.y > 0:
			velocity.y += gravity * gravity_factor * delta
		else:
			velocity.y += gravity * delta
		if not is_jumping:
			animation_player.play("Jump")
			is_jumping = true
	else:
		if is_jumping:
			is_jumping = false
			reset_to_idle_or_walk()

	handle_movement(delta)

	move_and_slide()

func handle_movement(delta):
	var direction = 0
	if player_controlling:
		direction = Input.get_axis("Move Left", "Move Right")
	
	if direction != 0:
		velocity.x = direction * speed
		sprites_node.scale.x = sign(direction)
		if is_on_floor() and not is_jumping:
			animation_player.play("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, speed*2.5 * delta)
		if is_on_floor() and not is_jumping:
			animation_player.play("idle")

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		jump()

func jump():
	velocity.y = jump_velocity
	audio_stream_player.play_track(0)
	animation_player.play("Jump")
	is_jumping = true

func reset_to_idle_or_walk():
	if animation_player.current_animation == "Jump":
		animation_player.stop()
		if abs(velocity.x) > 0 and Input.get_axis("Move Left", "Move Right") != 0:
			animation_player.play("Walk")
		else:
			animation_player.play("idle")

func player_hurt(vec2):
	if damage_timer.is_stopped():
		velocity -= (global_position - vec2) * 5
		damage_timer.start(5)
		print(damage_timer.time_left)
		health -= 10
		print("Player hurt! Health is now: ", health)
		if health <= 0:
			die()

func return_home():
	player_controlling = false
	global_position = original_position
	sprites_node.visible = false
	var particle_systems = particle_systems_node.get_children(false)
	for particle_system: CPUParticles2D in particle_systems:
		particle_system.emitting = true
	await get_tree().create_timer(1).timeout
	for particle_system: CPUParticles2D in particle_systems:
		particle_system.emitting = false
	sprites_node.visible = true
	player_controlling = true
	
	
	
	

func die():
	print("Player has died!")
	# Handle game over logic here
	



func _on_took_damage_timer_timeout():
	print("Can take damange again.")
