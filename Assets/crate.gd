extends RigidBody

onready var World = get_node("/root/Spatial")

func _physics_process(delta):
	if translation.y <= 0.3:
		World.add_score(10)
		queue_free()

