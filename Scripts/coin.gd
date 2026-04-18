extends Area2D

func _ready() -> void:
	# Sinyali kodla bağlayarak editör hatalarını devre dışı bırakıyoruz
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		print("Altın toplandı!")
		call_deferred("queue_free")

func free_coin():
	queue_free()
