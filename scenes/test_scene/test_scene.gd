class_name CombatScene
extends Node3D

@export var combat_grid:CombatGrid

func _ready() -> void:
	if not combat_grid:
		push_error("No combat grid for combat scene " + name + "!")
		return
	
	combat_grid.setup_grid()

func move_request() -> void:
	pass
