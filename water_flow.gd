extends Node3D

@onready var water = $Water

var is_train = true
@onready var file_train = FileAccess.open("res://height_info_train.txt",FileAccess.WRITE)
@onready var file_test = FileAccess.open("res://height_info_test.txt",FileAccess.WRITE)

func _ready():
	var timer = get_tree().create_timer(35.0)
	timer.connect("timeout",record_test)

func _process(delta):
	var height = sin(Time.get_ticks_msec()/2000.0)*PI
	water.position.y= height
	
	if is_train:
		file_train.store_line(str(height))
	else:
		file_test.store_line(str(height))

func record_test():
	print("train collected.")
	is_train = false
	var timer = get_tree().create_timer(5.0)
	var quit = Callable(get_tree(),"quit")
	timer.connect("timeout",quit)
