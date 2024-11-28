extends Area2D
enum WarpType {RETURN, PROCEED}

@export var warp_type : WarpType
@export var return_point : Vector2



func _on_body_entered(body):
	print(body.name)
	if warp_type == WarpType.RETURN:
		if body.has_method("return_home"):
			body.return_home()
