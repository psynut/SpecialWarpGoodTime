extends Camera2D

@export var player_node : Node2D
@export var target_offset : Vector2

func _process(delta):
	position = player_node.global_position + target_offset
