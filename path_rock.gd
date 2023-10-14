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
var ttl = 8

# Called when the node enters the scene tree for the first time.
func _ready():
	start = false
	pass



func go():
	angle = deg_to_rad(init_angle)
	#print(Vector2(cos(angle), sin(angle)))
	apply_central_impulse(Vector2(cos(angle), sin(angle)) * init_speed)
	start = true

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ttl -= delta
	if(ttl < 0):
		self.queue_free()




func hit_planet(info):
	#print("path rock dead")
	if(not info.is_in_group("wall")):
		self.queue_free()

