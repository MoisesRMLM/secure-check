extends Control

# Drag the .tres resources into this array in the inspector
@export var email_list: Array[EmailData]

func _ready():
	if GameManager.tutorial_shown == false:
		$StartPanel.show()
	else:
		$StartPanel.hide()
	# Upon loading, we remove the buttons that have already been processed
	for email_id in GameManager.deleted_emails:
		if has_node("VBoxContainer/" + email_id):
			get_node("VBoxContainer/" + email_id).queue_free()
	GameManager.total_emails=email_list.size()
	update_hearts()
	
	
# --- SIGNALS CONNECTED FROM THE EDITOR ---

func _on_button_pressed():
	_go_to_email(0, "Button")

func _on_button_2_pressed():
	_go_to_email(1, "Button2")

func _on_button_3_pressed():
	_go_to_email(2, "Button3")

func _on_button_4_pressed():
	_go_to_email(3, "Button4")

func _on_button_5_pressed():
	_go_to_email(4, "Button5")

# --- UNIFIED FUNCTIONS FOR ACCEPT/DECLINE ---

func _on_accept_pressed(node_name: String, index: int):
	var data = email_list[index]
	
	if data.is_phishing:
		# Error: Accepted a phishing email
		GameManager.lose_life()
		update_hearts()
		print("Mistake")
	else:
		# Correct: Accepted a legitimate email
		print("Correct")
	
	_remove_from_inbox(node_name)
	GameManager.check_victory_condition()

func _on_decline_pressed(node_name: String, index: int):
	var data = email_list[index]
	
	if data.is_phishing:
		# Correct: Identified and blocked phishing
		print("Correct")
	else:
		# Error: Declined a legitimate email
		GameManager.lose_life()
		update_hearts()
		print("Mistake")
	
	_remove_from_inbox(node_name)
	GameManager.check_victory_condition()

# --- LOGIC FUNCTIONS ---

func _go_to_email(index: int, node_name: String):
	if index < email_list.size():
		GameManager.current_email_data = email_list[index]
		get_tree().change_scene_to_file("res://Scenes/email.tscn")

func _remove_from_inbox(node_name: String):
	if not node_name in GameManager.deleted_emails:
		GameManager.deleted_emails.append(node_name)
	
	# We search for the node dynamically by its name
	if has_node("VBoxContainer/" + node_name):
		get_node("VBoxContainer/" + node_name).queue_free()

# --- LIVES ---
func update_hearts():
	if has_node("Header/Heart1"):
		$Header/Heart1.visible = GameManager.lives >= 1	
		$Header/Heart2.visible = GameManager.lives >= 2
		$Header/Heart3.visible = GameManager.lives >= 3

# --- Start  ---
func _on_start_mission_pressed():
	$StartPanel.hide()
	GameManager.tutorial_shown = true
	print("Game started!")

# --- HELP PANEL BUTTONS ---

# Help button
func _on_help_pressed():
	$HelpPanel.show()

# Close button on help panel
func _on_close_help_pressed():
	$HelpPanel.hide()
