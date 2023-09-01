extends Area2D

var new_gravity = Vector2(0, -1000)  # gravity force
var velocity = Vector2()  # the area's velocity

func _process(delta):
	velocity += new_gravity * delta 
	self.position += velocity * delta
