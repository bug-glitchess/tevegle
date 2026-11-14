extends Control

@onready var score_texture = %Score/ScoreTexture
@onready var score_label = %Score/ScoreLabel

func _process(_delta):
	score_label.text = "P1: %d   P2: %d" % [GameManager.scores[1], GameManager.scores[2]]
