extends CharacterBody2D

const WORDS = ["max", "red", "blue", "cheese", "jam", "dog", "canary", "parmesan", "boulder", "itchy", "papper", "clock", "orange", "citrus", "pillow", "pures", "cat", "plumber", "dice", "mouse", "bottle", "banana", "burnt", "saussage", "croco", "neon", "light", "chiken", "seagull", "robot", "castle", "water", "plushie", "star", "flying", "barrel", "sam"]
const SYMBOLS = ["!", "@", "$", "%", "&", "/", "=", "?", "+", "-", ",", ".", "*"]
const LETTERS = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m"]
const NUMBER_PASS_TYPES: int = 4
const MAX_DISTANCE: int = 2000

var pass_type: int #Determines how the password will generate
var random_number: int
var secure: bool
var trashed: bool = false
var waiting_removal: bool = false
var distance: int = 0

func _ready():
	%passwd.text = ""
	pass_type = (int)(NUMBER_PASS_TYPES*randf())
	match(pass_type):
		0: #This password type is not secure
			secure = false
			
			%passwd.text += str(WORDS.pick_random())
			for i in 2*randf():
				%passwd.text += str((int)(9*randf()))
		1: #This password type is secure
			secure = true
			
			for i in 2*randf()+1:
				%passwd.text += str(WORDS.pick_random())
				%passwd.text += str(SYMBOLS.pick_random())
			for i in 6*randf():
				%passwd.text += str((int)(9*randf()))
		2: #This password type is secure
			secure = true
			
			for i in 2*randf()+2:
				%passwd.text += str(WORDS.pick_random())
			%passwd.text += str(SYMBOLS.pick_random())
			for i in 6*randf()+1:
				%passwd.text += str((int)(9*randf()))
		3: #This password is secure
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
		4: #This password is not secure
			secure = false
			
			random_number = (int)(2*randf())
			match(random_number):
				0: %passwd.text += "Hello world!"
				1: %passwd.text += "123456"
				3: %passwd.text += "654321"
				4: %passwd.text += "password"
				5: %passwd.text += "password1234"
				6: %passwd.text += "user"
				7: %passwd.text += "admin"
				8: %passwd.text += "p@$$w0rd"
				9: %passwd.text += "@dmin"
				10: %passwd.text += "us3r"

func _physics_process(delta: float) -> void:
	if !trashed:
		velocity.y = 200
		move_and_slide()
		
		distance += 5
		if distance >= MAX_DISTANCE:
			queue_free()
	else:
		if !waiting_removal:
			waiting_removal = true
			
			global_position.x = 100*randf()+911
			global_position.y = 458
			rotation_degrees = 45*randf()+45
			
			%TrashedTimer.start()

func _on_trashed_timer_timeout() -> void:
	queue_free()
