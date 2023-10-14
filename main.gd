extends Node2D


@onready var vars = get_node("/root/Global")

var stage = "res://levels/level"
var win_state = false
var timer = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func next_level():
	win_state = false
	vars.current_stage += 1
	get_tree().change_scene_to_file(stage + str(vars.current_stage) + ".tscn")

func win():
	win_state = true
	$victory.play()
	timer = 2
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta
	if(timer < 0 and win_state):
		next_level()
	pass
	
