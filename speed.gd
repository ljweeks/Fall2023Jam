extends Area2D


@export var speed : float = 1000


signal clicked

var held = false
var mouse_over = false
var mouse_time = 0
var meteor_in = false
var wait = 0
func _ready():
	#$Area2D/CollisionShape2D.shape.set_radius(grav_size)
	pass
	

func _physics_process(delta):
	pass


func entered_grav(body):
	if(body.is_in_group("meteor") or body.is_in_group("path_rock")):
		meteor_in = true
		#print("entered")
		body.apply_central_impulse(Vector2(cos(self.rotation), sin(self.rotation)) * speed)
		#body.grav_apply($end.global_position, gravity, 500)


func exited_grav(body):
	pass
