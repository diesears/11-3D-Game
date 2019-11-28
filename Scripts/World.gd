extends Spatial

onready var Score = $HUD/Score
onready var Lives = $HUD/Lives
onready var hearts = [$HUD/Lives/Heart1,$HUD/Lives/Heart2,$HUD/Lives/Heart3,$HUD/Lives/Heart4,$HUD/Lives/Heart5]

var heart_full = load("res://Assets/heart.png")
var heart_half = load("res://Assets/heart_half.png")
var heart_empty = load("res://Assets/heart_empty.png")



var score = 1000
var lives = 10

func _unhandled_input(event):
	if Input.is_action_pressed("quit"):
		get_tree().quit()

func add_score(s):
	score += s
	Score.text = str(score)

func update_lives(delta):
	lives += delta
	for h in range(len(hearts)):
		hearts[h].texture = heart_full
		if lives < (h+1)*2:
			hearts[h].texture = heart_empty
		if lives == (h*2)+1:
			hearts[h].texture = heart_half

func _on_Crate_body_entered(body):
	pass # Replace with function body.
