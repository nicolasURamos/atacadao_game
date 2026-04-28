extends Enemy

func _on_contact_hitbox_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage(damage)
