# this component holds logic for managing a combat scene, will be used in all combat scenes.
class_name CombatScene
extends Node3D

@export var combat_grid:CombatGrid # reference to a child combat grid component.
@export var camera_rig:CameraRig # reference to a child camera rig component.

@export var active_critter:Critter # reference to a child critter, will expand to 2 or 4 critters for combat purposes.

@export var camera_offset:Vector3

var grid_center:Vector3
var move_smoothing:float = 0.5 # amount of smoothing when tweening the movement of character, currently unused.

func _ready() -> void:
	# ready checks, if any essential component is missing it will crash.
	if not combat_grid:
		push_error("No combat grid for combat scene " + name + "!")
		return
	if not camera_rig:
		push_error("No camera rig for combat scene " + name + "!")
		return
	if not active_critter: # added for testing, should be removed as critters should be summoned after scene loads.
		push_error("No active critter for combat scene " + name + "!")
		return
	
	# combat grid and camera position setup.
	camera_rig.position = combat_grid.setup_grid() + camera_offset
	
	# set camera to place player side on left of screen.
	camera_rig.set_perspective(active_critter.team)
	
	# for testing, should be called when a critter is summoned into combat.
	active_critter.grid_position = Vector2i(1, 1) if active_critter.team == GlobalVariables.Team.A else Vector2i(4, 1)
	active_critter.request_move.connect(move_request)
	summon_critter(active_critter)

# called when critter sends a move request signal, validates move and does critter movement.
func move_request(direction:Vector2i) -> void:
	var adjusted_direction:Vector2i = direction if active_critter.team == GlobalVariables.Team.A else direction * -1
	if combat_grid.is_occupy_valid(
		active_critter.grid_position.x + adjusted_direction.x,
		active_critter.grid_position.y + adjusted_direction.y, 
		active_critter.team):
		active_critter.grid_position += adjusted_direction
		var target_cell:GridCell = combat_grid.grid[active_critter.grid_position.x][active_critter.grid_position.y]
		active_critter.move_to(Vector3(target_cell.global_position.x, 0, target_cell.global_position.z))

# summons critters in combat, currently only used in ready check, should be used everytime trainer summons a critter.
func summon_critter(critter:Critter) -> void:
	if not combat_grid.is_occupy_valid(critter.grid_position.x, critter.grid_position.y, critter.team):
		push_error("Invalid summon position for " + critter.name)
		return
	var target_cell:GridCell = combat_grid.grid[critter.grid_position.x][critter.grid_position.y]
	critter.position = target_cell.global_position
