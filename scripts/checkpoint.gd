extends Area2D

@export var message_string : String
@export var level_ui : Node

@onready var display_sprite = $"Display Text"

var awaiting_input = false
var activated = false

func _ready():
	display_sprite.visible = false
	
func _process(delta):
	if !activated && awaiting_input && Input.is_key_pressed(KEY_E):
		level_ui.display_message(message_string)
		display_sprite.visible = true
		activated = true

func _on_body_entered(body):
	if !activated:
		await_interaction()
	else:
		level_ui.display_message(message_string)

func _on_body_exited(body):
	level_ui.display_message(String())
	awaiting_input = false

func await_interaction():
	level_ui.display_message("Press \"e\" to interact")
	awaiting_input = true
