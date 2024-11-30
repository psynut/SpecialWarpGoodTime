extends Node2D

var star_sprites : Array[Texture]
var particle_systems : Array[CPUParticles2D]
@onready var sprite2d = $Sprite2D
@onready var scene_manager = get_node("%Scene Manager")
var music_player : AudioStreamPlayer
@onready var victory_song = load("res://audio/Beat One.mp3")

var current_index = 0

func _ready():
	music_player = get_node("%Music Player")
	particle_systems = [$CPUParticles2D,$CPUParticles2D2]
	star_sprites = [ResourceLoader.load("res://sprites/Star01.png"),ResourceLoader.load("res://sprites/Star02.png"),ResourceLoader.load("res://sprites/Star03.png")]
	for particle_system in particle_systems:
		particle_system.emitting = false
	sprite2d.modulate = Color.hex(0xFFFFFF00)



func _on_timer_timeout():
	current_index+=1
	if current_index == star_sprites.size():
		current_index =0
	sprite2d.texture = star_sprites[current_index]


func _on_area_2d_body_entered(body):
	for particle_system in particle_systems:
		particle_system.emitting = true
	sprite2d.modulate = Color.hex(0xFFFFFFFF)
	body.player_controlling = false
	music_player.stop()
	music_player.stream = victory_song
	music_player.play()
	await get_tree().create_timer(10).timeout
	scene_manager.load_next_scene()

