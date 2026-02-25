extends CharacterBody2D

const WORDS = ["max", "red", "blue", "cheese", "jam", "dog", "canary", "parmesan", "boulder", "itchy", "paper", "clock", "orange", "citrus", "pillow", "pures", "cat", "plumber", "dice", "mouse", "bottle", "banana", "burnt", "saussage", "croco", "neon", "light", "chiken", "seagull", "robot", "castle", "water", "plushie", "star", "flying", "barrel", "sam"]
const SYMBOLS = ["!", "@", "$", "%", "&", "/", "=", "?", "+", "-", ",", ".", "*"]
const LETTERS = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m"]
const SPECIAL_PASSWORDS = ["Hello world", "123456", "654321", "password", "password1234", "user", "admin", "p@$$w0rd", "@dmin", "us3r"]
const PASS_TYPE_LIST = ["word", "combinedv1", "combinedv2", "random", "special"]
const MAX_DISTANCE: int = 2000

var pass_type: String #Determines how the password will generate
var random_number: int
var secure: bool
var trashed: bool = false
var distance: int = 0

func _ready():
	%passwd.text = ""
	pass_type = PASS_TYPE_LIST.pick_random()
	match(pass_type):
		"word": #This password type is not secure
			secure = false
			
			%passwd.text += str(WORDS.pick_random())
			for i in 2*randf():
				%passwd.text += str((int)(9*randf()))
		"combinedv1": #This password type is secure
			secure = true
			
			for i in 2*randf()+1:
				%passwd.text += str(WORDS.pick_random())
				%passwd.text += str(SYMBOLS.pick_random())
			for i in 6*randf():
				%passwd.text += str((int)(9*randf()))
		"combinedv2": #This password type is secure
			secure = true
			
			for i in 2*randf()+2:
				%passwd.text += str(WORDS.pick_random())
			%passwd.text += str(SYMBOLS.pick_random())
			for i in 6*randf()+1:
				%passwd.text += str((int)(9*randf()))
		"random": #This password is secure
			secure = true
			
			for i in 9*randf()+9:
				random_number = (int)(2*randf())
				match(random_number):
					0:
						%passwd.text += str(LETTERS.pick_random())
					1:
						%passwd.text += str(SYMBOLS.pick_random())
					2:
						%passwd.text += str((int)(9*randf()))
		"special": #This password is not secure
			secure = false
			
			%passwd.text += SPECIAL_PASSWORDS.pick_random()

func _process(_delta):
	if !trashed:
		velocity.y = 200
		move_and_slide()
		
		distance += 5
		if distance >= MAX_DISTANCE:
			if !secure:
				get_tree().call_group("level1", "incorrect")
			
			queue_free()

func _on_trashed_timer_timeout() -> void:
	queue_free()

#Note: Button is set to max modulate.a to make it invisible
func _on_button_pressed() -> void:
	trashed = true
	global_position.x = 130*randf()+950
	global_position.y = 450
	global_rotation_degrees = 0
	rotation_degrees = 20*randf()+80
	
	if !secure:
		get_tree().call_group("level1", "correct")
	else:
		get_tree().call_group("level1", "incorrect")
	
	%Button.disabled = true
	%TrashedTimer.start()
