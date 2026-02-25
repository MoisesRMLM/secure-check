extends Node2D

const PASSWORD = preload("res://Scenes/password.tscn")

var contador: int = 0

func _ready():
	%Contador.text = str(contador) + "/10"

#When the counter reaches 10, you complete the level
func correct():
	contador += 1
	%Contador.text = str(contador) + "/10"

func incorrect():
	pass #Add LifeBar code here

func spawn_password():
	%Spawner.progress_ratio = randf()
	
	var new_password = PASSWORD.instantiate()
	new_password.global_position = %Spawner.global_position
	new_password.rotation_degrees = 90*randf()-45
	%Spawner.add_child(new_password)

func _on_spawn_time_timeout() -> void:
	%SpawnTime.wait_time = 2*randf()+1
	spawn_password()
