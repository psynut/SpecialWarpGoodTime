extends Enemy

@onready var animation_player = $AnimationPlayer
@onready var wall_detector = $"Wall Detector"
@onready var sound_stream_player = $AudioStreamPlayer2D
@onready var softspot = $"Softspot Area2D"
var walking = false

func _ready():
	make_noises()
	speed = 100
	wall_detector.connect("wall_detected", _on_detected_wall)
	softspot.connect("body_entered", _on_softspot_bumped)
	check_movement()
	
func _physics_process(delta):
	pass
	if speed > 0 && walking == false:
		walking = true
		animation_player.play("Walking")
	if speed == 0 && walking == true:
		walking = false
		animation_player.stop()

func _on_detected_wall():
	jump()

func _on_stuck_at_ledge():
	jump()

func check_movement():
	var x_pos = global_position.x
	await get_tree().create_timer(1).timeout
	if absf(x_pos-global_position.x) < 2:
		jump()
	check_movement()

func make_noises():
	await get_tree().create_timer(randf_range(4,6)).timeout
	sound_stream_player.play_track(randi_range(0,sound_stream_player.sound_clips.size()-1))
	make_noises()
	
func turn_around():
	speed = 0-speed
