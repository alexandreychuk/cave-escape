extends Node2D

# member variables here, example:
var level;
var player;

func _ready():
	level = preload( "res://scenes/level.scn" ).instance();
	add_child(level);
	player = preload ("res://scenes/player.scn" ).instance();
	player.set_pos( Vector2( level.get_node("PlayerStart").get_pos().x, level.get_node("PlayerStart").get_pos().y ) );
	add_child(player);
	pass


