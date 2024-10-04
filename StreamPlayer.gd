extends StreamPlayer

var tracks = [
	#load("res://Spookyscape01.ogg"),
	#load("res://Spookyscape02.ogg"),
	load("res://Assets/Music/Loop00.ogg"),
	load("res://Assets/Music/Loop01.ogg"),
	load("res://Assets/Music/Loop02.ogg"),
	load("res://Assets/Music/Loop03.ogg"),
	load("res://Assets/Music/Loop04.ogg"),
	load("res://Assets/Music/Loop05.ogg"),
	load("res://Assets/Music/Loop06.ogg"),
	load("res://Assets/Music/Loop07-16bar.ogg"),
	load("res://Assets/Music/Loop08.ogg"),
	load("res://Assets/Music/Loop09.ogg"),
	load("res://Assets/Music/Loop10-4bardrum.ogg"),
	load("res://Assets/Music/Loop11-4bardrumorg.ogg")
	]

var next_track = 0

func _ready():
	randomize()
	set_stream(tracks[next_track])
	play()
	shuffle()

func shuffle():
	#randomize()
	next_track = randi() % tracks.size() #var random_number = randi() % (max - min + 1) + min

func _input(event):
	if Input.is_action_pressed("move_faster"):
		shuffle()


func _on_StreamPlayer_finished():
	set_stream(tracks[next_track])
	play()
	shuffle()
