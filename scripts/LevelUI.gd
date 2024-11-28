extends Control

@export var lowest_position = -100
@onready var message_label = $Label

var relative_y_to_camera

func _ready():
	message_label.text = String()

func _process(delta):
	pass
	
func display_message(message):
	message_label.text = message
	
