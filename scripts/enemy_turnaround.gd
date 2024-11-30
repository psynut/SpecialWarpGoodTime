extends Area2D

func _on_body_entered(body):
	if body.has_method("turn_around"):
		print(str(["turned around ", body.name]))
		body.turn_around()
