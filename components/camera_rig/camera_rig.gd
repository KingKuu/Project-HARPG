# this component holds data for the camera, currently used for combat scene but will expand to overworld when needed.
class_name CameraRig
extends Node3D

# rotates the rig so that the player will be on the left side of the screen.
func set_perspective(team:GlobalVariables.Team) -> void:
	rotation_degrees.y = 0.0 if team == GlobalVariables.Team.A else 180.0
