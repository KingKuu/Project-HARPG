# this component holds logic for a combat grid in the style of MegaManBattleNetwork.
class_name CombatGrid
extends Node3D

# color to be assigned to cells based on team designation.
const CELL_COLOR:Dictionary = {
	GlobalVariables.Team.A: Color.BLUE,
	GlobalVariables.Team.B: Color.RED
}

# size of each cell, used for grid setup.
@export var cell_size:int = 1
@export var grid_dimension:Vector2 = Vector2(6, 3)
@export var cell_sprite:PackedScene
# the current combat grid, first array is columns, second array is collection of gridcell nodes.
var grid:Array[Array]
# a dictionary holding cell references.
var cell_reference:Dictionary

# creates the grid, assigns it to the grid and cell_reference variables, and sets initial color.
# returns grid center.
func setup_grid() -> Vector3:
	if not cell_sprite:
		push_error("No cell sprite for " + " to use!")
	
	var column_index:int = 0
	while column_index < grid_dimension.x:
		var cell_index:int = 0
		var cell_group:Array[GridCell]
		while cell_index < grid_dimension.y:
			var cell:GridCell = cell_sprite.instantiate()
			add_child(cell)
			cell.position = Vector3i(column_index, 0, cell_index)
			if column_index > (grid_dimension.x/2) - 1:
				cell.cell_team = GlobalVariables.Team.B
			set_cell_color(cell, cell.cell_team)
			cell_group.append(cell)
			cell_reference[cell] = Vector2i(column_index, cell_index)
			cell_index += 1
		grid.append(cell_group)
		column_index += 1
	
	return Vector3(grid_dimension.x/2, 0, grid_dimension.y/2)

# sets the color of the selected cell, currently only bases off of team.
func set_cell_color(cell:GridCell, color:GlobalVariables.Team) -> void:
	cell.modulate = CELL_COLOR[color]

# checks if the requested cell is valid to move to, currently only checks cell and actor team.
func is_occupy_valid(column:int, row:int, team:GlobalVariables.Team) -> bool:
	if column < 0 or row < 0 or column >= grid.size() or row >= grid[column].size():
		return false
	var cell:GridCell = grid[column][row]
	return cell.cell_team == team

# changes the team of selected cell, automatically changes it's color.
func change_cell_team(column:int, row:int, new_team:GlobalVariables.Team) -> void:
	var cell:GridCell = grid[column][row]
	cell.cell_team = new_team
	set_cell_color(cell, new_team)
