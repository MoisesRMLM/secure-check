extends Control

func _ready():
	# We read the data before change the scene
	$MarginContainer/VBoxContainer/VBoxContainer2/sender.text = "Sender: " + GameManager.current_email_data.sender
	$MarginContainer/VBoxContainer/VBoxContainer2/subject.text = "Subject: " + GameManager.current_email_data.subject
	$MarginContainer/VBoxContainer/RichTextLabel.text = GameManager.current_email_data.body

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/inbox.tscn")
