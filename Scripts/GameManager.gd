extends Node

var deleted_emails = []
var current_email_data: EmailData
var lives: int = 3
var total_emails: int = 0 # This will be set by the Inbox
var tutorial_shown: bool = false


func lose_life():
	lives -= 1
	print("Lives remaining: ", lives)
	if lives <= 0:
		print("Game Over")
		# Give a small delay so the player sees the last mistake
		await get_tree().create_timer(0.3).timeout
		get_tree().change_scene_to_file("res://Scenes/game_over2.tscn")

func check_victory_condition():
	# If all emails in the list have been processed, player wins
	if deleted_emails.size() >= total_emails and lives > 0:
		print("Victory!")
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/victory2.tscn")
		

func reset_game():
	lives = 3
	deleted_emails.clear()
	# Si tienes más variables como puntos o tiempo, resetealas aquí también
