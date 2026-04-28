extends CanvasLayer
class_name TelaTransicao

@export var start_with_fadein := false

signal transition_ready

func _ready() -> void:
	if start_with_fadein:
		$AnimationPlayer.play("out")
	
func start_transition() -> void:
	$AnimationPlayer.play_backwards("out")
	await $AnimationPlayer.animation_finished
	await get_tree().process_frame
	transition_ready.emit()
