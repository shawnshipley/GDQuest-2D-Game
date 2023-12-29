extends CharacterBody2D

signal health_depleted

@onready var happy_boo = $HappyBoo
@onready var hurt_box = $HurtBox
@onready var progress_bar = $ProgressBar

var health = 100.0
const DAMAGE_RATE = 5.0

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()
	print(velocity)
	print(velocity.length())
	if velocity.length() > 0.0:
		happy_boo.play_walk_animation()
	else:
		happy_boo.play_idle_animation()
	var overlapping_mobs = hurt_box.get_overlapping_bodies()
	if overlapping_mobs:
		health -= overlapping_mobs.size() * DAMAGE_RATE * delta
		progress_bar.value = health
		if health <= 0:
			health_depleted.emit()
			visible = false
