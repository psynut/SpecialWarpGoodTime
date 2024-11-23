extends Enemy

@export var hop_time_min = 2
@export var hop_time_max = 9
@onready var hop_timer = $"Hop Timer"

func _ready():
	hop_timer.connect("timeout", hop)
	hop_timer.start(randf_range(hop_time_min, hop_time_max))


func hop():
	print("Hop!")
	jump()
