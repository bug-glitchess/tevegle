extends Node2D

var scores := {1: 0, 2: 0}

func add_score(player_id : int):
	scores[player_id] += 1

func reset():
	scores = {1: 0, 2: 0}

func load_next_level(next_scene : PackedScene):
	get_tree().change_scene_to_packed(next_scene)
