extends CanvasLayer

onready var transition = $Transition
var mobsAmount = 5

func removeMob():
	mobsAmount -= 1
	if mobsAmount == 0:
		get_tree().change_scene("res://World/Success.tscn")

func _ready():
	$Load.start()
	transition.open(1.0,0.25)

func _on_Load_timeout():
	$Player.show()
	$Zombie.show()
	$Zombie2.show()
	$Zombie3.show()
	$Skeleton.show()
	$Skeleton2.show()

func _on_Mob_screenExited():
	get_tree().change_scene("res://World/GameOver.tscn")

func _on_Mob_killed():
	removeMob()
