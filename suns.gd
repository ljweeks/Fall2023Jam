extends StaticBody2D


@export var gravity : float = 500
@export var grav_size : int = 100
@export var planet_size : int = 1


signal clicked

var held = false
var mouse_over = false
var mouse_time = 0
var meteor_in = false
var wait = 0
var can_move = true
var dir
func _ready():
	$grav_field_area.set_gravity(gravity)
	$grav_field_area/gravity_field_collision.shape.set_radius(grav_size)
	$grav_field_area.set_gravity_point_unit_distance((grav_size / 1.5))
	dir = randi_range(0,1)
	if(dir == 0):
		dir -= 1
	$center/edge1.position.y = -grav_size
	$center/edge2.position.x = grav_size
	$center/edge3.position.y = grav_size
	$center/edge4.position.x = -grav_size
	var sprite_size = $Sprite2D.get_rect()
	print(sprite_size.size.x)
	$CollisionShape2D.shape = CircleShape2D.new()
	$CollisionShape2D.shape.radius = (sprite_size.size.x/4)
	randomize()


	
func _physics_process(delta):
	$Sprite2D.rotate(deg_to_rad(1) * dir)
	$center.rotate(deg_to_rad(1))










func movable(value):
	can_move = not value
