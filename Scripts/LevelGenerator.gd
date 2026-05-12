extends Node2D

# Tek bir sahne yerine, Inspector'dan birden fazla sahne ekleyebileceğimiz bir dizi (Array) oluşturuyoruz
@export var chunk_scenes: Array[PackedScene] 
var next_spawn_x: float = 0.0
var chunk_width: float = 1152.0

func _ready():
	for i in range(3):
		spawn_chunk()

func spawn_chunk():
	var random_chunk = chunk_scenes.pick_random() 
	var new_chunk = random_chunk.instantiate()
	new_chunk.position.x = next_spawn_x
	add_child(new_chunk)
	next_spawn_x += chunk_width
