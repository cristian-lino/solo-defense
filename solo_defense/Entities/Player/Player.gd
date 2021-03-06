extends KinematicBody2D

onready var _animated_sprite = $AnimatedSprite
onready var _attackCollision = $SwordHit/CollisionShape2D
var screen_size

var isAttacking = false
export (int) var speed = 300
var velocity = Vector2()

func _ready():
	hide()

func _physics_process(delta):
	velocity = Vector2()
	
	if Input.is_action_pressed("right") && !isAttacking:
		velocity.x += 1
		_animated_sprite.play("walk")
	elif Input.is_action_pressed("left") && !isAttacking:
		velocity.x -= 1
		_animated_sprite.play("walk")
	elif Input.is_action_pressed("down") && !isAttacking:
		velocity.y += 1
		_animated_sprite.play("walk")
	elif Input.is_action_pressed("up") && !isAttacking:
		velocity.y -= 1
		_animated_sprite.play("walk")
	else:
		if isAttacking == false:
			_animated_sprite.play("idle")
			
	velocity = velocity.normalized() * speed
	
	if Input.is_action_pressed("attack"):
		_animated_sprite.play("attack")
		isAttacking = true
		_attackCollision.disabled = false
	
	move_and_collide(velocity * delta)
		

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "attack":
		_attackCollision.disabled = true
		isAttacking = false
