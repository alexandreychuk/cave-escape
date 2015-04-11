
extends Area2D

var collected = false

func _fixed_process(delta):
	if (collected):
		free()

func _ready():
	set_fixed_process(true)
	pass

func _on_1up_body_enter( body ):
	if (not collected and body extends preload("res://scenes/player.gd")):
		get_node("Sprite").hide()
		body.add_lives(1)
		body.sound.play("pickup")
		collected = true



