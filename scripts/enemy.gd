class_name Enemy
extends CharacterBody2D

func _physics_process(delta):
	if get_slide_collision_count()>0:
		print("Detected collision")
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			print("Collided with: ", collision.get_collider().name)
 
