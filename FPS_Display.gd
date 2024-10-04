extends Label

var frame_count = 0
var time_passed = 0.0

func _ready():
	set_process(true)

func _process(delta):
	frame_count += 1
	time_passed += delta
	
	if time_passed >= 1.0:
		set_text("FPS: " + str(frame_count))
		frame_count = 0
		time_passed = 0.0