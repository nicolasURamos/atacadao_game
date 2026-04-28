extends Timer
class_name HitStop

func slow_time() -> void:
	Engine.time_scale = 0.1
	start()
	await timeout
	Engine.time_scale = 1
