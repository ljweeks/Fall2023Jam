extends Node2D

@export var init_speed : float = 100
@export var init_angle : float = 90
@export var total : int = 1


var meteorScene = load("res://meteor.tscn")
var path_rock = load("res://path_rock.tscn")
var meteor
var start = false
var points = 0
var shot_time = 0
var timer = 0
var time_to_wait = 0.7
var path_item
# Called when the node enters the scene tree for the first time.
func _ready():
	$sata1.rotate(deg_to_rad(init_angle))
	$sata2.rotate(deg_to_rad(init_angle))
	$shot.rotate(deg_to_rad(init_angle))
	$sata2.hide()
	pass # Replace with function body.

func create_meteor():
	meteor = meteorScene.instantiate()
	meteor.rotate(deg_to_rad(init_angle))
	meteor.dead.connect(planet_hit)
	meteor.show()
	add_child(meteor)
	meteor.global_position = self.global_position
	meteor.init_angle = init_angle
	meteor.init_speed = init_speed
	meteor.go()
	
func planet_hit():
	print("planet hit")
	restart()

func restart():
	points = 0
	if(meteor != null):
		meteor.queue_free()
	start = false
	for item in get_tree().get_nodes_in_group("planet"):
		item.movable(start)
	for item in get_tree().get_nodes_in_group("alien"):
		item.restart()
	
	# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	shot_time -= delta
	
	if(shot_time < 0):
		$sata1.show()
		$sata2.hide()
	
	timer -=  delta
	if(timer < 0 and start == false):
		var new_path_item = path_rock.instantiate()
		#path_item = meteorScene.instantiate()
		new_path_item.rotate(deg_to_rad(init_angle))
		new_path_item.dead.connect(planet_hit)
		new_path_item.show()
		add_child(new_path_item)
		new_path_item.global_position = global_position
		new_path_item.init_angle = init_angle
		new_path_item.init_speed = init_speed
		timer = time_to_wait
		new_path_item.go()
		
	if(Input.is_action_just_pressed("restart")):
		restart()
	if(Input.is_action_just_pressed("start") and start == false):
		$shot.emitting = true
		$shoot.play()
		start = true
		$sata1.hide()
		$sata2.show()
		shot_time = 0.25
		for item in get_tree().get_nodes_in_group("path_rock"):
			item.queue_free()
		create_meteor()
		for item in get_tree().get_nodes_in_group("planet"):
			item.movable(start)
	pass

func point():
	points += 1
	print("points now at")
	if(points >= total):
		win()

func win():
	print("player won")
	var main = get_tree().get_first_node_in_group("main")
	main.win()
	
	pass
