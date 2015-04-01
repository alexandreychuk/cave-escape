extends KinematicBody2D

const GRAVITY = 981.0;
const WALK_SPEED = 200;
const JUMP_FORCE = 500;
const JUMP_CD = 0.1;

var velocity = Vector2();
var isJumping = false;
var jumpTimer = 0.0;
var anim;
var sprite;
var sound;

var health = 6;
var lives = 3;
var coins = 0;

func _on_HUD_mouse_enter():
	print("Mouse entered huehue")

func _fixed_process(delta):
	# Get player components
	# DEBUG
	anim = get_node("Sprite/animator");
	sprite = get_node("Sprite");
	sound = get_node("sfxPlayer");
	# ======================================
	
	velocity.y += delta * GRAVITY;
	
	if (Input.is_action_pressed("ui_left")):
		velocity.x = -WALK_SPEED;
		sprite.set_flip_h(true);
		if (anim.get_current_animation() != "walking"):
			anim.play("walking");
	elif (Input.is_action_pressed("ui_right")):
		velocity.x = WALK_SPEED;
		sprite.set_flip_h(false);
		if (anim.get_current_animation() != "walking"):
			anim.play("walking");
	elif (Input.is_action_pressed("ui_accept")):
		if (anim.get_current_animation() != "shoot"):
			anim.play("shoot");
		velocity.x = 0;
	else:
		velocity.x = 0;
		if (anim.get_current_animation() != "idle"):
			anim.play("idle");
			
	# initiate jumping
	if (Input.is_action_pressed("ui_up") && !isJumping && jumpTimer <= 0):
		sound.play("jump");
		velocity.y -= JUMP_FORCE;
		isJumping = true;
		
	if (isJumping):
		if (anim.get_current_animation() != "jump"):
			anim.play("jump");
	
	var motion = velocity * delta;
	move( motion );
	
	if (is_colliding()):
		var n = get_collision_normal();
		if (n.y != 0):
			if (isJumping):
				jumpTimer = JUMP_CD;
			isJumping = false;
		
		if (jumpTimer > 0):
			jumpTimer -= delta;
		motion = n.slide( motion );
		velocity = n.slide( velocity );
		move( motion );
		
	if (get_pos().y > 720):
		set_pos( Vector2( get_pos().x, 0) );
		lives -= 1;
		emit_signal("lives_changed",lives)

func _ready():
	# Initialization here
	# anim = get_node("Sprite/animator");
	# sprite = get_node("Sprite");
	# sound = get_node("SamplePlayer2D");
	set_fixed_process(true);
	add_user_signal("lives_changed")
	pass


