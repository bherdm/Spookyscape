extends Node2D

onready var witch = get_node("../witch")

var Xoffset

func _ready():
	Xoffset = get_pos().x - witch.get_pos().x

func _on_Timer_timeout():
	set_pos(Vector2(witch.get_pos().x + Xoffset, get_pos().y))
