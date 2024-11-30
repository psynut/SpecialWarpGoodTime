extends Area2D
enum WarpType {RETURN, PROCEED}

@export var warp_type : WarpType
@export var return_point : Vector2
@export var message = ""

@export var level_ui : Node

@onready var scene_manager = get_node("%Scene Manager")
@onready var particle_system = $CPUParticles2D

func _ready():
	if warp_type == WarpType.PROCEED:
		particle_system.color = Color.hex(0x3FC44CFF)
	else:
		particle_system.color = Color.hex(0xD02536FF)


func _on_body_entered(body):
	print(body.name)
	if warp_type == WarpType.RETURN:
		if body.has_method("return_home"):
			if message == "":
				print("No message")
				body.return_home()
			else:
				print("The message is: " + message)
				body.player_controlling = false
				await get_tree().create_timer(1).timeout
				level_ui.display_message(message)
				await get_tree().create_timer(5).timeout
				body.return_home()
	else:
		scene_manager.load_scene("res://scenes/level_02.tscn")

