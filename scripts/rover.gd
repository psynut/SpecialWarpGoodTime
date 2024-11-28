extends Enemy

@onready var animation_player = $AnimationPlayer
@onready var wall_detector = $"Wall Detector"
var walking = false

func _ready():
	speed = 100
	wall_detector.connect("wall_detected", _on_detected_wall)
	
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
