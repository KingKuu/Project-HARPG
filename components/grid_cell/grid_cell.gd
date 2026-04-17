# this class holds logic for cell sprites showing the valid cells players can occupy.
class_name GridCell
extends Sprite3D

# determines team of cell, used for grid management and state visibility through color.
@export var cell_team:GlobalVariables.Team = GlobalVariables.Team.A
