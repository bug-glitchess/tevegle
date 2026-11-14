extends Camera2D

func _process(delta):
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() == 0:
		return
	var center = Vector2.ZERO
	for p in players:
		center += p.global_position
	center /= players.size()
	global_position = global_position.lerp(center, 8 * delta)
