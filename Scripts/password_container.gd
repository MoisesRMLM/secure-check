extends Node2D

const WORDS = ["max", "cheese", "jam", "dog", "canary", "parmesan", "boulder", "itchy", "papper", "clock", "orange", "citrus", "pillow", "pures", "cat", "plumber", "dice", "mouse", "bottle", "banana", "burnt", "saussage", "croco", "neon", "light", "chiken", "seagull", "robot", "castle", "water", "plushie", "star", "sam"]
const SYMBOLS = ["!", "@", "$", "%", "&", "/", "=", "?", "+", "-", ",", ".", "*"]
const LETTERS = ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l", "z", "x", "c", "v", "b", "n", "m"]
const NUMBER_PASS_TYPES: int = 3

var pass_type: int = 1 #Determines how the password will generate

func _ready():
	%passwd.text = ""
	#(Remove the # when finished) pass_type = NUMBER_PASS_TYPES*randf()
	match(pass_type):
		0:
			%passwd.text += str(WORDS.pick_random())
			for i in 4*randf():
				%passwd.text += str((int)(9*randf()))
		1:
			for i in 4*randf()+1:
				%passwd.text += str(WORDS.pick_random())
				%passwd.text += str(SYMBOLS.pick_random())
			for i in 9*randf():
				%passwd.text += str((int)(9*randf()))
		2:
			pass
