extends RigidBody2D


class_name RigidBox

var max_speed : int = 30

func _integrate_forces(state):
	if self.linear_velocity.length() > max_speed:
		var direction = self.linear_velocity.normalized()
		self.linear_velocity.x = direction.x * max_speed
		self.linear_velocity.y = direction.y * max_speed

