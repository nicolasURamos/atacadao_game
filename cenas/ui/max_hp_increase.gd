extends Button

func _on_pressed() -> void:
	get_parent().deactivate()
	
	var player := get_tree().get_first_node_in_group("player") as Player
	player.health += 1
