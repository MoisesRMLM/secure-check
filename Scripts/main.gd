extends Node2D

@onready var anim_player = $AnimationPlayer
@onready var player_sprite = $Player/AnimatedSprite2D
@onready var footsteps = $Player/FootSteps
@onready var desktop_screen = $DesktopScreen
@onready var logo = $Logo

func _ready():
	player_sprite.animation = "walk"
	player_sprite.play()
	footsteps.play()
	anim_player.play()
	anim_player.connect("animation_finished", Callable(self, "_on_animation_finished"))
	

func _on_animation_finished(anim_name):
	if anim_name == "FirstAnimationPlayer":
		footsteps.stop()
		player_sprite.animation = "idle"
		player_sprite.play()

func _input(event):
	if event is InputEventMouseButton:
		if event.double_click and event.pressed:
			if $CanvasLayer/DesktopScreen/Logo.get_rect().has_point(to_local(event.position)):
				$AnimationPlayer.play("FirstAnimationPlayer")

func pause_animation():
	$AnimationPlayer.pause()
