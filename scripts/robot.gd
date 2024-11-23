extends Enemy

var floor_detector

func _ready():
	speed = 100
	floor_detector = $"Floor Detector"
	floor_detector.connect("no_floor", turn_around)
	
func turn_around():
	print("turning around")
	speed = 0-speed
