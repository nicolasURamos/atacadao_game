extends CanvasLayer

func _on_play_pressed() -> void:
	$TelaTransicao.start_transition()
	await $TelaTransicao.transition_ready
	get_tree().change_scene_to_packed(load("res://cenas/game.tscn"))

func _on_quit_pressed() -> void:
	$TelaTransicao.start_transition()
	await $TelaTransicao.transition_ready	
	get_tree().quit()
