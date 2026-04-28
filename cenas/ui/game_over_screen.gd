extends Control

@onready var tela_transicao : TelaTransicao = get_tree().get_first_node_in_group("tela_transicao")

func _ready() -> void:
	var player := get_tree().get_first_node_in_group("player") as Player
	player.death.connect(activate)
	visible = false
	
func activate() -> void:
	visible = true
	$AnimationPlayer.play("activate")
	get_tree().paused = true

func _on_restart_pressed() -> void:
	tela_transicao.start_transition()
	await tela_transicao.transition_ready
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_main_menu_pressed() -> void:
	tela_transicao.start_transition()
	await tela_transicao.transition_ready
	get_tree().paused = false
	get_tree().change_scene_to_packed(load("res://cenas/ui/main_menu.tscn"))
