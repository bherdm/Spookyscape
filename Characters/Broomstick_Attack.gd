extends Area2D

func _on_BroomstickArea2D_area_enter( area ):
	if area.get_parent().has_method("whacked"):
		area.get_parent().whacked()
