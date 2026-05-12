extends Node2D

@export var chunk_scenes: Array[PackedScene]
@export var player_path: NodePath
@export var chunk_width: float = 1152.0
@export var initial_chunk_count: int = 3
@export var preload_distance: float = 900.0
@export var cleanup_distance: float = 1400.0

var next_spawn_x: float = 0.0
var active_chunks: Array[Node2D] = []
var player: Node2D

func _ready() -> void:
	player = get_node_or_null(player_path)
	if player == null:
		player = get_parent().get_node_or_null("Player")

	for i in range(initial_chunk_count):
		spawn_chunk()

func _process(_delta: float) -> void:
	if player == null:
		return

	while player.global_position.x + preload_distance > next_spawn_x:
		spawn_chunk()

	cleanup_old_chunks()

func spawn_chunk() -> void:
	if chunk_scenes.is_empty():
		return

	var random_chunk = chunk_scenes.pick_random()
	var new_chunk = random_chunk.instantiate()
	new_chunk.position.x = next_spawn_x
	add_child(new_chunk)
	active_chunks.append(new_chunk)
	next_spawn_x += chunk_width

func cleanup_old_chunks() -> void:
	while not active_chunks.is_empty():
		var oldest_chunk = active_chunks.front()
		var chunk_end_x = oldest_chunk.global_position.x + chunk_width
		if chunk_end_x >= player.global_position.x - cleanup_distance:
			break

		active_chunks.pop_front()
		oldest_chunk.queue_free()
