extends RigidBody2D


signal dead
var init_speed 
var init_angle
var init_impulse
var start_pos
var is_start = true
var angle
var start = false
var gravs = []

# Called when the node enters the scene tree for the first time.
func _ready():
	start = false
	$CPUParticles2D.emitting = false
	pass
	



func go():
	is_start = false
	start = true
	$CPUParticles2D.emitting = true
	angle = deg_to_rad(init_angle)
	print(Vector2(cos(angle), sin(angle)))
	apply_central_impulse(Vector2(cos(angle), sin(angle)) * init_speed)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(start == true):
		constant_force = Vector2(0,0)



func hit_planet(info):
	#print("hit planet")
	if(not info.is_in_group("wall")):
		dead.emit()
