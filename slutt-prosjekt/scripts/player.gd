extends CharacterBody2D

# hoppehastighet og løpe hastighet
const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D

var is_attacking = false
var current_attack = ""

func _ready():
	# Koble signalet "frame_changed" fra animated_sprite til metoden _on_frame_changed i denne klassen
	animated_sprite.connect("frame_changed", Callable(self,"_on_frame_changed"))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and not is_attacking:
		velocity.y = JUMP_VELOCITY

	# Få inngangsretningen og håndter bevegelsen/bremsingen.
	# byttet til move left og move right i input map som gjør at man kan lage sine egne bevegelser knapper
	var direction = Input.get_axis("move_left", "move_right")
	
		
	# flip player 
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true 
		
	# check for attack input
	if Input.is_action_just_pressed("attack1") and is_on_floor() and not is_attacking:
		attack1()
	elif Input.is_action_just_pressed("attack2") and is_on_floor() and not is_attacking:
		attack2()
		

	# play animation only if not attacking
	if not is_attacking:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
		else:
			animated_sprite.play("jump")
			
		if direction and not is_attacking: 
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		move_and_slide()
	
func attack1():
	is_attacking = true
	current_attack = "attack1"
	animated_sprite.speed_scale = 1.5
	animated_sprite.play("attack1")

func attack2():
	is_attacking = true
	current_attack = "attack2"
	animated_sprite.speed_scale = 1.5
	animated_sprite.play("attack2")

func _on_frame_changed():
	if is_attacking and animated_sprite.animation == current_attack:
		if animated_sprite.frame == animated_sprite.sprite_frames.get_frame_count(current_attack) - 1:
			is_attacking = false
			animated_sprite.speed_scale = 1.0 
	
	
