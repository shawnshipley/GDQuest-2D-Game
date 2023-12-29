extends Node2D

@onready var timer = $Timer
@onready var path_follow_2d = $Player/Path2D/PathFollow2D
@onready var player = $Player
@onready var game_over = $GameOver


func _ready():
	player.connect("health_depleted", Callable(self, "_on_player_health_depleted"))
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	timer.wait_time = 0.5
	timer.start()

func spawn():
	const MOB = preload("res://mob.tscn")
	var new_mob = MOB.instantiate()
	path_follow_2d.progress_ratio = randf()
	new_mob.global_position = path_follow_2d.global_position
	add_child(new_mob)
	
func _on_timer_timeout():
	spawn()

func _on_player_health_depleted():
	game_over.visible = true
	get_tree().paused = true
