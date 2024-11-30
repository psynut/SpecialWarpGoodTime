extends Node2D

#if wait_time = 0 next scene will not autoload
@export var wait_time = 0
@export var next_scene : PackedScene

@onready var timer = $Timer

func _ready():
	timer.connect("timeout", load_next_scene)
	if wait_time > 0:
		print("Setting Timer")
		timer.start(wait_time)
	
func load_next_scene():
	print("Loading Next Scene")
	get_tree().change_scene_to_packed(next_scene)

func load_scene(scene):
	get_tree().change_scene_to_file(scene)
