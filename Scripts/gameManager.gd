extends Node
var score: int = 0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		GameManager.score += 1 # Puanı artır
		print("Altın toplandı! Toplam Puan: ", GameManager.score)
		call_deferred("queue_free") # free_coin fonksiyonuna gerek kalmadan direkt böyle de yazabilirsin
