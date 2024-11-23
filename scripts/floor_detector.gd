extends Node2D

signal no_floor

var collision_mask = 0b10000

@onready var raycast_target = $Marker2D

func _physics_process(delta):
	var space_state = get_world_2d().direct_space_state
	#use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(global_position, raycast_target.global_position, collision_mask, [self])
	var result = space_state.intersect_ray(query)
	if !result:
		emit_signal("no_floor")
	
