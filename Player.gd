extends KinematicBody2D

const SPEED = 60
const GRAVITY = 10
const START_POS = Vector2(10, 50)

# Negative because in Godot y up is negative direction
const JUMP_POWER = -150
const FLOOR = Vector2(0, -2)

# Preloading resources
const FIREBALL = preload("res://Fireball.tscn")

var velocity = Vector2()
var on_ground = false
var is_attacking = false

func shootFireball():
	# Creates a single fireball instance
	var fireball = FIREBALL.instance()
	
	# Set the current direction to the fireball 
	fireball.set_fireball_direction(sign($FireballShootPosition.position.x))
	
	# Create fireball as a child node to the player
	get_parent().add_child(fireball)
	
	# Set fireball position to Position2D node
	fireball.position = $FireballShootPosition.global_position
	

func _input(event):
	# Checks if event is "just happened"
	var just_pressed = event.is_pressed() and not event.is_echo()
	
	if Input.is_key_pressed(KEY_SPACE) and just_pressed and !is_attacking:
		
		if on_ground:
			velocity.x = 0
		
		is_attacking = true
		$PlayerAnim.play("shoot")
		shootFireball()

func _physics_process(delta):
	
	# Move
	if (Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D)):
		
		if is_attacking == false or on_ground == false:
			velocity.x = SPEED
			$PlayerAnim.play("run")
			$PlayerAnim.flip_h = false
			
			# If fireball shoot position is on the left side (negative on X axis) of player -> switch it to the opposite side
			if sign($FireballShootPosition.position.x) == -1:
				$FireballShootPosition.position.x *= -1
				
		
	elif (Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A)):
		
		if is_attacking == false or on_ground == false:
			velocity.x = -SPEED
			$PlayerAnim.play("run")
			$PlayerAnim.flip_h = true
			
			# If fireball shoot position is on the right side (positive on X axis) of player -> switch it to the opposite side
			if sign($FireballShootPosition.position.x) == 1:
				$FireballShootPosition.position.x *= -1
			
	else:
		velocity.x = 0
		if on_ground and is_attacking == false:
			$PlayerAnim.play("idle")
		
	# Jump
	if (Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W)):
		if on_ground and is_attacking == false:
			velocity.y = JUMP_POWER
			on_ground = false
	
	on_ground = is_on_floor()
	
	if !on_ground:
		is_attacking = false
	
	if(on_ground == false and is_attacking == false):
		if(velocity.y < 0):
			$PlayerAnim.play("jump")
		else:
			$PlayerAnim.play("fall")
			
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)

func _on_PlayerAnim_animation_finished():
	is_attacking = false

# On screen exited event
func _on_VisibilityNotifier2D_screen_exited():
	position = START_POS
