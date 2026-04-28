extends Area2D
class_name Experience

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.experience += 1
		queue_free()
