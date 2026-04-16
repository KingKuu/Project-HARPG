class_name CombatGrid
extends Node3D

const CELL_COLOR:Dictionary = {
	GlobalVariables.Team.A: Color.BLUE,
	GlobalVariables.Team.B: Color.RED
}

var grid:Array[Array]
var cell_reference:Dictionary

func setup_grid() -> void:
	var column_index:int = 0
	for column in get_children():
		var cell_index:int = 0
		var cell_group:Array[Node3D]
		for cell in column.get_children():
			cell_group.append(cell)
			cell_reference[cell] = Vector2i(column_index, cell_index)
			cell_index += 1
		grid.append(cell_group)
		column_index += 1

func set_cell_color(column:int, row:int, color:GlobalVariables.Team) -> void:
	var cell:GridCell = grid[column][row]
	cell.modulate = CELL_COLOR[color]

func is_occupy_valid(column:int, row:int, team:GlobalVariables.Team) -> bool:
	var cell:GridCell = grid[column][row]
	return cell.cell_team == team

func change_cell_team(column:int, row:int, new_team:GlobalVariables.Team) -> void:
	var cell:GridCell = grid[column][row]
	cell.cell_team = new_team
