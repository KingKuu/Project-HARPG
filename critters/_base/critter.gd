# this is a base class all critters will inherit, contains logic and variables all critters will use.
class_name Critter
extends CharacterBody3D

# sends a signal up the tree that the critter wants to move to direction.
signal request_move(direction:Vector2i)

# the team designation of the critter, defaults to team A.
@export var team:GlobalVariables.Team

# current position of the critter in grid coordinates.
var grid_position:Vector2i

func _input(_event: InputEvent) -> void:
	
	# detects keyboard inputs for x and y axis, then emits a signal to request moving to desired direction.
	if Input.is_action_just_pressed("up"):
		request_move.emit(Vector2i(0, -1))
	elif Input.is_action_just_pressed("down"):
		request_move.emit(Vector2i(0, 1))
	elif Input.is_action_just_pressed("right"):
		request_move.emit(Vector2i(1, 0))
	elif Input.is_action_just_pressed("left"):
		request_move.emit(Vector2i(-1, 0))
