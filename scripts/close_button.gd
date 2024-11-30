extends TextureButton



func _on_pressed():
	var parent_node = get_node("..")
	parent_node.queue_free()
	
