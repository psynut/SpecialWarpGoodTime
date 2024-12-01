extends Control

@onready var progress_bar = $TextureProgressBar
@onready var percentage_label = $"TextureProgressBar/Percentage Label"

func change_value(value):
	progress_bar.value = value
	percentage_label.text = str(value, "%")
