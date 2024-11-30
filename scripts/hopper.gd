extends Enemy

@export var hop_time_min = 2
@export var hop_time_max = 9
@export var hop_x_speed = -100
@onready var audio_stream_player = $AudioStreamPlayer2D
@onready var hop_timer = $"Hop Timer"

var just_jumped=false

func _ready():
	hop_timer.connect("timeout", hop)
	hop_timer.start(randf_range(hop_time_min, hop_time_max))
	
func _physics_process(delta):
	if just_jumped && is_on_floor():
		speed = 0
		just_jumped = false


func hop():
	hop_timer.start(randf_range(hop_time_min, hop_time_max))
	audio_stream_player.play_track(0)
	jump()
	var rnd = randi_range(0,1)
	hop_x_speed = hop_x_speed if rnd == 0 else 0-hop_x_speed
	speed = hop_x_speed
	await get_tree().create_timer(.25).timeout
	just_jumped = true;
