extends Node2D

const PASSWORD = preload("res://Scenes/password.tscn")

var counter: int
var hp: int

func _ready():
	counter = 0
	hp = 5
	%Counter.text = str(counter) + "/10"
	%Hp.value = hp

#When the counter reaches 10, you complete the level
func correct():
	counter += 1
	%Counter.text = str(counter) + "/10"
	
	if counter >= 10:
		get_tree().change_scene_to_file("res://Scenes/victory1.tscn")

func incorrect():
	hp -= 1
	%Hp.value = hp
	
	if hp <= 0:
		get_tree().change_scene_to_file("res://Scenes/game_over1.tscn")

func spawn_password():
	%Spawner.progress_ratio = randf()
	
	var new_password = PASSWORD.instantiate()
	new_password.global_position = %Spawner.global_position
	new_password.rotation_degrees = 90*randf()-45
	%Spawner.add_child(new_password)

func _on_spawn_time_timeout() -> void:
	%SpawnTime.wait_time = 2*randf()+1
	spawn_password()
