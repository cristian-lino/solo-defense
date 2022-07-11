extends KinematicBody2D

signal screenExited
signal killed

onready var _animated_sprite = $AnimatedSprite
onready var tween = $Tween
onready var hitSound = $AudioStreamPlayer2D

var screen_size
var hasScreenExited = true

var speed = 5
export (float) var max_hp = 20

onready var hp = max_hp setget _set_hp

func _ready():
	_animated_sprite.playing = true
	_animated_sprite.animation = "walk"
	hide()

func _physics_process(delta):
	var velocity = Vector2()	
	velocity.x -= speed
	move_and_collide(velocity * delta)

func kill():
	speed = 0
	hasScreenExited = false
	_animated_sprite.play("dead")
	

func damage(amount):
	_set_hp(hp - amount)

func _set_hp(value):
	var prev_hp = hp
	hp = clamp(value, 0, max_hp)
	if hp != prev_hp:
		if hp == 0:
			kill()

func _on_Area2D_area_entered(area):
	if area.is_in_group("swordHit"):
		hitSound.play()
		damage(10)
		play_damage_effect()
		
func _on_VisibilityNotifier2D_screen_exited():
	if hasScreenExited:
		emit_signal("screenExited")

func _on_AnimatedSprite_animation_finished():
	if _animated_sprite.animation == "dead":
		emit_signal("killed")
		queue_free()

func play_damage_effect():
	tween.interpolate_property($AnimatedSprite, "modulate:a", 1, 0, 0.1)
	tween.start()
	yield(tween, "tween_completed")
	tween.interpolate_property($AnimatedSprite, "modulate:a", 0, 1, 0.1)
	tween.start()
