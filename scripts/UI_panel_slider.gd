extends Control

enum SliderPosition {CENTER, UP, RIGHT, DOWN, LEFT}
var current_position = SliderPosition.CENTER
@onready var animation_player = $AnimationPlayer

func center_to_left():
	if(current_position == SliderPosition.CENTER):
		animation_player.play("Center to Left")
		await get_tree().create_timer(animation_player.current_animation_length).timeout
		current_position = SliderPosition.LEFT
	else:
		push_error("Panel Slider called 'Center to Left'. Panel is not centered.")
func left_to_center():
	if(current_position == SliderPosition.LEFT):
		animation_player.play_backwards("Center to Left")
		await get_tree().create_timer(animation_player.current_animation_length).timeout
		current_position = SliderPosition.CENTER
	else:
		push_error("Panel Slider called 'Left to Center'. Panel is not centered.")
