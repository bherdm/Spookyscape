extends Area2D



func _on_Ghost_body_enter( body ):
	if body.get_name() == "witch":
		body.die()
