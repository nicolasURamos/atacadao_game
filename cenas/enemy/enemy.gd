extends CharacterBody2D
class_name Enemy

@export var health : int = 1
@export var speed : float = 50
@export var damage : int = 1
@export var EXP_SCENE : PackedScene
@export var BOOM_SCENE : PackedScene

var accel : float = 20

func _physics_process(_delta: float) -> void:
	var player := get_tree().get_first_node_in_group("player") as Player
	var direction := global_position.direction_to(player.global_position)
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	move_and_slide()

	if abs(direction.y) > abs(direction.x):
		if direction.y > 0:
			$Sprite2D.play("baixo")
		elif direction.y<0:
			$Sprite2D.play("cima")
	else:
		if direction.x > 0:
			$Sprite2D.play("direita")
		elif direction.x<0:
			$Sprite2D.play("esquerda")
		
func take_damage(r_damage : int) -> void:
	health -= r_damage
	if health <= 0:
		queue_free() # Deleta o inimigo do jogo
	var tween := get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Sprite2D, "modulate:a", 1, 0.25).from(0)
	$AudioStreamPlayer2D.play()

## Chamada ao a cena estar sendo deletada.
func _on_tree_exiting() -> void:
	var exp : Experience = EXP_SCENE.instantiate()
	exp.global_position = global_position
	get_parent().call_deferred("add_child", exp)
	
func explosdion() -> void:
	var boom : AnimatedSprite2D = BOOM_SCENE.instantiate()
	boom.global_position = global_position
	get_parent().call_deferred("add_child", boom)
