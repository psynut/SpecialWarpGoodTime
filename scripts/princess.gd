extends Area2D

@export var level_ui : Node

@onready var scene_manager = get_node("%Scene Manager")

func _on_body_entered(body):
	body.player_controlling = false
	level_ui.display_message("You found the princess!")
	await get_tree().create_timer(5).timeout
	level_ui.display_message("You've made no progress.")
	await get_tree().create_timer(5).timeout
	level_ui.display_message("")
	scene_manager.load_next_scene()
