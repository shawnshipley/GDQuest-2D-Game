extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
@onready var slime = $Slime

var health = 3

func _ready():
	slime.play_walk()

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()

func take_damage():
	health -= 1
	slime.play_hurt()
	
	if health <= 0:
		const SMOKE_EXPLOSION = preload("res://smoke_explosion/smoke_explosion.tscn")
		var new_smoke_explosion = SMOKE_EXPLOSION.instantiate()
		new_smoke_explosion.global_position = global_position
		get_parent().add_child(new_smoke_explosion)
		queue_free()
