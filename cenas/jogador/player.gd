extends CharacterBody2D
class_name Player

var health : int = 3:
	set(new_value):
		health = new_value
		update_health_bar()
var damage : int = 1
var attack_speed : float = 0.6:
	set(new_value):
		attack_speed = max(0.05, new_value)

var experience : int = 0:
	set(new_value):
		experience = new_value
		increase_exp_func()

var direction : Vector2
var anim_dir : Vector2

const speedy = 100
const MAX_EXP = 10

signal death

@export var PROJECTILE_SCENE : PackedScene

func _physics_process(_delta: float) -> void:	
	var input_dir := Input.get_vector("esquerda","direita", "cima", "baixo")
	direction = input_dir
	if input_dir != Vector2.ZERO:
		anim_dir = input_dir
		
	if health > 0:
		velocity.x=move_toward(velocity.x,speedy*direction.x,20)
		velocity.y=move_toward(velocity.y,speedy*direction.y,20)
	move_and_slide()
	try_shooting()
	
	if velocity.length()>0:
		animatewalk()
	else:
		animateidle()

func take_damage(r_damage : int) -> void:
	health -= r_damage
	if health <= 0:
		handle_death()
		
	var tween := get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Sprite2D, "modulate:a", 1, 0.25).from(0)
	$Camera2D.add_trauma(0.5)
	$Hurt.play()
	
	var hit_stop := get_tree().get_first_node_in_group("hit_stop") as HitStop
	hit_stop.slow_time()
	
		
func handle_death() -> void:
	$Sprite2D.visible = false
	set_collision_layer_value(1, false)
	set_physics_process(false)
	death.emit()
	
func animatewalk()->void:
	if anim_dir.y > 0:
		$Sprite2D.play("walk_baixo")
		return
	elif anim_dir.y<0:
		$Sprite2D.play("walk_cima")
		return
	
	if anim_dir.x > 0:
		$Sprite2D.play("walk_direita")
	elif anim_dir.x<0:
		$Sprite2D.play("walk_esquerda")
		
func animateidle()-> void:
	if anim_dir.y > 0:
		$Sprite2D.play("idle_baixo")
		return
	elif anim_dir.y<0:
		$Sprite2D.play("idle_cima")
		return
	
	if anim_dir.x > 0:
		$Sprite2D.play("idle_direita")
	elif anim_dir.x<0:
		$Sprite2D.play("idle_esquerda")
	
func try_shooting() -> void:
	if !Input.is_action_pressed("tiro"):
		return
	elif $Cooldown.time_left > 0.0:
		return
		
	var projectile : Projectile = PROJECTILE_SCENE.instantiate()
	projectile.damage = damage
	projectile.global_position = global_position
	projectile.look_at(get_global_mouse_position())
	get_parent().add_child(projectile)
	$Cooldown.start(attack_speed)
	

func increase_exp_func() -> void:
	if experience == MAX_EXP:
		experience -= MAX_EXP
		level_up_func()
		
	var progress_bar := get_tree().get_first_node_in_group("xp_bar") as TextureProgressBar
	progress_bar.value = experience
	progress_bar.max_value = MAX_EXP
	$xp_sound.better_play()
	
func level_up_func() -> void:
	var upgrade_container := get_tree().get_first_node_in_group("upgrade_container") as UpgradeContainer
	upgrade_container.activate()

func update_health_bar() -> void:
	var progress_bar := get_tree().get_first_node_in_group("hp_bar") as TextureProgressBar
	progress_bar.value = health

# "walk_" in "walk_baixo" == true /// "walk_" in "idle_baixo"
func _on_sprite_2d_frame_changed() -> void:
	if "walk_" in $Sprite2D.animation and $Sprite2D.frame in [1, 3]:
		$WalkSound.better_play()
