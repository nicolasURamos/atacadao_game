extends Area2D
class_name Projectile

@export var damage := 1
@export var speedBulet := 50

func _physics_process(delta: float) -> void:
	var direction := Vector2.RIGHT.rotated(rotation)
	position += speedBulet * direction * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()
