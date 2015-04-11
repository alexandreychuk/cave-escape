extends Node2D

# member variables here, example:
var level;
var player;
var hud;

func _ready():
	level = preload( "res://scenes/level.scn" ).instance();
	add_child(level);
	player = preload("res://scenes/player.scn" ).instance();
	player.set_pos( Vector2( level.get_node("PlayerStart").get_pos().x, level.get_node("PlayerStart").get_pos().y ) );
	add_child(player);
	hud = preload( "res://scenes/hud.scn" ).instance();
	player.connect("lives_changed", hud, "_on_Player_lives_changed")
	hud.get_node("lives").set_text("x "+var2str(player.lives))
	player.add_child( hud )
	hud.set_pos( Vector2(-640, 300) )
	pass


