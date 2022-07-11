extends CanvasLayer

onready var transition = $Transition

func _ready():
	transition.open(1.0,0.25)

func _on_Play_button_down():
	transition.close(1.0)
	$Load.start()

func _on_Load_timeout():
	get_tree().change_scene("res://UI/Horde.tscn")
