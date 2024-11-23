extends Control

@onready var panel_slider = $"Panel Slider"

func _ready():
	panel_slider.center_to_left()
