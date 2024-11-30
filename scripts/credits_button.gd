extends Button

@onready var credits_window = load("res://scenes/credits_window.tscn")
@onready var title_screen = get_node("/root/Title Screen")

func _ready():
	print(title_screen.name)

func _on_pressed():
	print("Credits Button Pressed")
	var credits_instance = credits_window.instantiate()
	title_screen.add_child(credits_instance)
	
