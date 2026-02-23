extends Node

var deleted_emails = []
var current_email_data: EmailData

# Add lives
var lives: int = 3

func lose_life():
	lives -= 1
	print("lives: ", lives)
	if lives <= 0:
		print("you lost")
		# Aqui  cambiar a una escena de derrota
