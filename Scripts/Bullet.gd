extends Area

onready var World = get_node("/root/World")

var speed = 15
var velocity = Vector3()

func start(xform):
	transform = xform
	velocity = transform.basis.z * speed

func _process(delta):
	transform.origin += velocity * delta

func _on_Timer_timeout():
	queue_free()

func _on_Bullet_body_entered(body):
	if body is StaticBody:
		#queue_free()
		pass
	if body.is_in_group("Crate"):
		World.add_score(100)
		queue_free()
		body.queue_free()