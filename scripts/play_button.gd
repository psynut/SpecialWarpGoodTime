extends Button

@onready var scene_manager = $"../../../Scene Manager"
@onready var panel_slider = $"../../../Panel Slider"

func _on_pressed():
	print("Play pressed")
	var button = self
	button.disabled = true
	if panel_slider != null:
		panel_slider.left_to_center()
		await get_tree().create_timer(1.6).timeout
	scene_manager.load_next_scene()

