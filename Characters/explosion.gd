extends Node2D

onready var timer = get_node("Timer")

func emit_explosion():
	for i in get_children():
		if i.has_method("set_emitting"):
			i.set_emitting(true)
	timer.start()

func _on_Timer_timeout():
	queue_free()
