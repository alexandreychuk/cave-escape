extends Control

var healthBar

func _on_Player_lives_changed(lives):
	get_node("lives").set_text("x "+var2str(lives))
	
func _ready():
	healthBar = get_node("HealthBar")
	pass


