extends Area2D

@export var speed = 250

func _process(delta):
	move_local_x(-speed*delta, true)



func _on_body_entered(body):
	if body.has_method("player_hurt"):
		body.player_hurt(global_position)
	queue_free()
