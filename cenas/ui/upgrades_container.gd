extends HBoxContainer
class_name UpgradeContainer

func _ready() -> void:
	visible = false

func activate() -> void:
	visible = true
	get_tree().paused = true

func deactivate() -> void:
	visible = false
	get_tree().paused = false
