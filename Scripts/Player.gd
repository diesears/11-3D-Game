extends KinematicBody

onready var World = get_node("/root/World")
onready var camera = $RotationHelper/Camera
onready var rotation_helper = $RotationHelper
onready var muzzle = $RotationHelper/Gun/Muzzle
var Bullet = preload("res://Scenes/Bullet.tscn")


var gravity = -30
var max_speed = 8
var mouse_sensitivity = 0.002  # radians/pixel

var jump = false
var jump_speed = 6
var can_move = true

var velocity = Vector3()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func get_input():
	var input_dir = Vector3()
	if !can_move:
		return input_dir
	# desired move in camera direction
	if Input.is_action_pressed("move_forward"):
		input_dir += -camera.global_transform.basis.z
	if Input.is_action_pressed("move_back"):
		input_dir += camera.global_transform.basis.z
	if Input.is_action_pressed("strafe_left"):
		input_dir += -camera.global_transform.basis.x
	if Input.is_action_pressed("strafe_right"):
		input_dir += camera.global_transform.basis.x
	input_dir = input_dir.normalized()
	jump = false
	if Input.is_action_just_pressed("jump"):
		jump = true	
	return input_dir


func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotation_helper.rotate_x(-event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		rotation_helper.rotation.x = clamp(rotation_helper.rotation.x, -1.2, 1.2)
	if event.is_action_pressed("shoot"):
		var b = Bullet.instance()
		b.start(muzzle.global_transform)
		get_parent().add_child(b)

func _physics_process(delta):
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	if jump and is_on_floor():
		velocity.y = jump_speed	
	move_and_slide(velocity, Vector3.UP, true)


func _on_Crate_body_entered(body):
	if can_move:
		World.update_lives(-1)
		velocity *= -1
		velocity.y = jump_speed
		move_and_slide(velocity, Vector3.UP, true)
		can_move = false
	yield(get_tree().create_timer(1), "timeout")
	can_move = true
