extends Spatial

onready var Score = $HUD/Score
onready var Lives = $HUD/Lives

var score = 0

func _unhandled_input(event):
	if Input.is_action_pressed("quit"):
		get_tree().quit()

func add_score(s):
	score += s
	Score.text = str(score)