extends Node2D

@export var collision_mask = 0b10000

signal wall_detected

@onready var raycast_target = $Marker2D

func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	#use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(global_position+Vector2(0,-1), raycast_target.global_position, collision_mask, [self])
	var result = space_state.intersect_ray(query)
	if result:
		print("wall detected")
		emit_signal("wall_detected")
