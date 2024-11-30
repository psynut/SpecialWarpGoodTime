extends Enemy

@onready var laser_starting_point = $"Laser Starting Point"
@onready var laser_raycast_point = $"Laser Starting Point/Laser Raycast Point"
@onready var laser_containter = $"Laser Container"
@onready var audio_stream_player = $AudioStreamPlayer2D
var floor_detector
var wall_detector
var laser_scene = preload("res://scenes/laser.tscn")

var fire_refractory = false

#var collision_mask = 0b10001

func _ready():
	speed = 100
	floor_detector = $"Floor Detector"
	floor_detector.connect("no_floor", turn_around)
	wall_detector = $"Wall Detector"
	wall_detector.connect("wall_detected", turn_around)
	
func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	#use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(laser_starting_point.global_position, laser_raycast_point.global_position, collision_mask, [self])
	var result = space_state.intersect_ray(query)
	if result:
		if result.collider.name == "Player" && fire_refractory == false :
			fire()
	
func turn_around():
	speed = 0-speed
	
func fire():
	var rand_track_index = randi_range(0, audio_stream_player.sound_clips.size()-1)
	audio_stream_player.play_track(rand_track_index)
	fire_refractory = true
	var laser_instance = laser_scene.instantiate()
	laser_containter.add_child(laser_instance)
	laser_instance.global_position = laser_starting_point.global_position
	if speed > 0:
		laser_instance.scale.x = 0-laser_instance.scale.x
	await get_tree().create_timer(1).timeout
	fire_refractory = false
	
