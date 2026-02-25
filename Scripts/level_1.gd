extends Node2D

const PASSWORD = preload("res://Scenes/password.tscn")

func spawn_password():
	%Spawner.progress_ratio = randf()
	
	var new_password = PASSWORD.instantiate()
	new_password.global_position = %Spawner.global_position
	new_password.rotation_degrees = 90*randf()-45
	%Spawner.add_child(new_password)

func _on_spawn_time_timeout() -> void:
	%SpawnTime.wait_time = 2*randf()+1
	spawn_password()
