extends AudioStreamPlayer
class_name AudioMelhor

@export var variacao_pitch : float = 0.0
@onready var pitch_original := pitch_scale

func better_play() -> void:
	pitch_scale = pitch_original + randi_range(variacao_pitch * -1, variacao_pitch)
	play()
