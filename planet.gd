extends StaticBody2D


@export var gravity : float = 500
@export var grav_size : int = 100
@export var planet_size : int = 1


signal clicked
var planets = ["res://planets/planet1.png", "res://planets/planet2.png", "res://planets/planet3.png"]
var held = false
var mouse_over = false
var mouse_time = 0
var meteor_in = false
var wait = 0
var can_move = true
var moving = RandomNumberGenerator.new()
func _ready():
	$grav_field_area.set_gravity(gravity)
	$Sprite2D.texture = load(planets[planet_size-1])
	$center/edge1.position.y = -grav_size
	$center/edge2.position.x = grav_size
	$center/edge3.position.y = grav_size
	$center/edge4.position.x = -grav_size
	var sprite_size = $Sprite2D.get_rect()
	print(sprite_size.size.x)
	$CollisionShape2D.shape = CircleShape2D.new()
	$CollisionShape2D.shape.radius = (sprite_size.size.x/4)
	randomize()
	var shape = CircleShape2D.new()
	shape.radius = grav_size
	$grav_field_area/gravity_field_collision.shape = shape
	$grav_vis.set_emission_shape(CPUParticles2D.EMISSION_SHAPE_SPHERE)
	$grav_vis.set_emission_sphere_radius(grav_size+10)

	
func _physics_process(delta):
	$center.rotate(deg_to_rad(1))
	if(not mouse_over):
		mouse_time -= delta
	if(Input.is_action_just_pressed("click") and can_move and mouse_over):
		moving = true
	if(Input.is_action_just_released("click")):
		moving = false
	if(Input.is_action_pressed("click") and mouse_time > 0 and can_move and moving):
		mouse_time = 0.05
		global_transform.origin = get_global_mouse_position()
	if(Input.is_action_just_pressed("nudge") and mouse_over):
		global_transform.origin = self.position + Vector2(randf_range(-100, 100), randf_range(-100, 100))


func _mouse_enter():
	mouse_time = 1000000
	#print("mouse entered")
	mouse_over = true
	
func _mouse_exit():
	mouse_over = false




func movable(value):
	can_move = not value
