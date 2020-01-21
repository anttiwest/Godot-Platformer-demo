extends KinematicBody2D

const SPEED = 40
const GRAVITY = 10
const FLOOR = Vector2(0, -1)

var velocity = Vector2()
var direction = 1
var is_dead = false

func _ready():
	pass
	
func _physics_process(delta):
	if is_dead == false:
		$EnemyAnim.play("run")
		$EnemyAnim.flip_h = direction == -1
		
		velocity.x = SPEED * direction
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR)
		
		if is_on_wall() or $RayCast2D.is_colliding() == false:
			direction = direction * -1
			$RayCast2D.position.x *= -1
		
func die():
	is_dead = true
	velocity = Vector2(0,0)
	$EnemyAnim.flip_h = false
	$EnemyAnim.play("dead")
	$CollisionShape2D.queue_free()
	$Timer.wait_time = 4	
	$Timer.start()
	z_index = -1

func _on_Timer_timeout():
	queue_free()
