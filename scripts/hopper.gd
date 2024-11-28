extends Enemy

@export var hop_time_min = 2
@export var hop_time_max = 9
@export var hop_x_speed = -100
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
	print("Hop!")
	hop_timer.start(randf_range(hop_time_min, hop_time_max))
	jump()
	var rnd = randi_range(0,1)
	hop_x_speed = hop_x_speed if rnd == 0 else 0-hop_x_speed
	speed = hop_x_speed
	print(velocity.x)
	await get_tree().create_timer(.25).timeout
	just_jumped = true;
