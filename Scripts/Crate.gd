extends RigidBody

func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(4)