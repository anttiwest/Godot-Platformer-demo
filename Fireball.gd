extends Area2D

const SPEED = 200
var velocity = Vector2()
var direction = 1 # Represents right direction (default)
var destroyed = false

func _ready():
	pass
	
func _physics_process(delta):
	if destroyed == false:
		velocity.x = SPEED * delta * direction
		translate(velocity)
		$FireballAnim.play("shoot")
	
# On exit screen event
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func set_fireball_direction(dir):
	direction = dir
	$FireballAnim.flip_h = dir == -1

# On collision with other collider node event
func _on_Fireball_body_entered(body):
	destroyed = true
	velocity.x = 0
	translate(velocity)
	$FireballAnim.play("explode")
	
	# Checks if the collided node is "Enemy"
	if "Enemy" in body.name:
		body.die()

func _on_FireballAnim_animation_finished():
	if destroyed:
		queue_free()
