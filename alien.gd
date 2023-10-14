extends Area2D

var visable = true
var wait

# Called when the node enters the scene tree for the first time.
func _ready():
	wait = true
	time_to_wait = randf_range(0.01, 3)
	print(time_to_wait)
	pass # Replace with function body.

var rotate_dir = true
var time = 0.75
var time_to_wait;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(wait == true and time_to_wait > 0):
		time_to_wait -= delta
	elif(wait == true):
		wait = false
	else:
		time -= delta
		if(rotate_dir and time > 0):
			rotate(deg_to_rad(0.15) )
		elif(rotate_dir):
			time = 1.5
			rotate_dir = false
			#print("swap dir")
			
		if(not rotate_dir and time > 0):
			rotate(deg_to_rad(0.15) * -1)
		elif(not rotate_dir):
			time = 1.5
			rotate_dir = true
	if(Input.is_action_just_pressed("restart")):
		restart()
	pass



func _on_body_entered(body):
	if(body.is_in_group("meteor") and visable):
		#print("hit")
		$splat.play()
		$CPUParticles2D.emitting = true
		$Sprite2D.hide()
		#play sploot sound
		var start_node = get_tree().get_first_node_in_group("start")
		start_node.point()
		visable = false
		

func restart():
	$Sprite2D.show()
	visable = true
