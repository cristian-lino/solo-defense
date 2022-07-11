extends CanvasLayer

onready var transition = $Transition

func _ready():
	transition.open(1.0,0.25)
	$Load.start()

func _on_Timer_timeout():
	transition.close(1.0)
	$Load2.start()

func _on_Load2_timeout():
	get_tree().change_scene("res://World/World.tscn")
