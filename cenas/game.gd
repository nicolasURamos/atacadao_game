extends Node2D

@export var ENEMY_SCENE : PackedScene

func _on_enemy_spawner_timer_timeout() -> void:
	if get_tree().get_node_count_in_group("enemy") >= 50:
		return
	
	var enemy : Enemy = ENEMY_SCENE.instantiate()
	$Path2D/PathFollow2D.progress_ratio = randf()
	enemy.global_position = $Path2D/PathFollow2D.global_position
	add_child(enemy)
