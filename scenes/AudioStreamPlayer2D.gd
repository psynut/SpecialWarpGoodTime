extends AudioStreamPlayer2D

@export var sound_clips : Array[AudioStream]

func play_track(track_number):
	stream = sound_clips[track_number]
	play()
