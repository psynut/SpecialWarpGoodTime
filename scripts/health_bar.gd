extends Control

@onready var progress_bar = $ProgressBar

func change_value(value):
	progress_bar.value = value
