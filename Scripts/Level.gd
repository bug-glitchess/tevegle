extends Node2D

func _ready():
	GameManager.reset()
	var ball = get_tree().get_first_node_in_group("Ball")
	ball.fell.connect(_on_ball_fell)

func _on_ball_fell(ball):
	var loser = null
	var best = INF
	for p in get_tree().get_nodes_in_group("Player"):
		var d = abs(p.global_position.x - ball.global_position.x)
		if d < best:
			best = d
			loser = p
	GameManager.add_score(3 - loser.player_id)
	ball.reset_ball()
