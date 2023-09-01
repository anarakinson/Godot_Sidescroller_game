extends Node


class_name State
# template class used for all states. 
# its own methods are empty
# methods below will be overrided in state nodes

# variable stored current states
var state_machine = null

# receives events from the "_unhandled_input()" callback in StateMachine
func handle_input(_event):
	pass

# corresponds to the "_process()" callback in StateMachine
func update(_delta):
	pass

# corresponds to the "_physics_process()" callback in StateMachine
func physics_update(_delta):
	pass

# calling by StateMachine upon changing the active state |
# the msg parameter was removed, see tutorials below     v
func enter():
	pass

# cleans up current state, used by StateMachine
func exit():
	pass



# tutorials:	
# GDQuest Channel: https://www.youtube.com/c/Gdquest
# GDQuest State Machine Article: https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqa3pvelQyUHVRU2FIN01WNWgwQ2daS0hFMTlmQXxBQ3Jtc0tsSWZ0NzBwckhPcVJIZlNoaExJbUYyYk1sR2szQzBiS0JMbDRZYzRuLXhhNHRNTmEyRWRyNTY4ZHloQ2I1X29yUWc3Y0ZiVS1jdEt0OUkwZldqejJqVHM3M0JRbkNSMllqNkpGVHdrUHhIakVWcG9JWQ&q=https%3A%2F%2Fwww.gdquest.com%2Ftutorial%2Fgodot%2Fdesign-patterns%2Ffinite-state-machine%2F&v=lC0XcLWAhPQ
# Godot State Design Pattern: https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqbnl3RElCTG11VTZ3eG1UeEhiYjdNS1pEaFEtUXxBQ3Jtc0ttU3VNUTRPd2lRMTVzcm4xdThUODZQYUlGWm1yZERwcTVuVzdFSDdPNDN4b25KQWg5QzBpVnNMMXV2SUl0QlphS2Jzb3NXX2ktS1c0WWFmQVhmZGltQWpGMy1TWFJvSG1tbzFKNjVTWXQzamRUcEJDMA&q=https%3A%2F%2Fdocs.godotengine.org%2Fen%2Fstable%2Ftutorials%2Fmisc%2Fstate_design_pattern.html&v=lC0XcLWAhPQ

