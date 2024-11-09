extends Control

#NODES
var stacks = null

#VARIABLES
var selected_node = null
var selected_size = 999
var team = "red"

#INSTANCES
var stack = preload("res://stack.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stacks = $stacks


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		var object_clicked = find_objects_clicked().get_parent()
		if object_clicked == null:
			pass
		else:
			if selected_node == null and team in object_clicked.occupants:
				selected_node = object_clicked
			elif team not in object_clicked.occupants and selected_node == null:
				print("ppp")
			else:
				create_stack(object_clicked)
	if Input.is_action_just_pressed("escape"):
		selected_node = null
	if (selected_node != null):
		if (team not in selected_node.occupants):
			selected_node = null
	
func find_objects_clicked():
	var mouse_pos = get_viewport().get_mouse_position()
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(mouse_pos, mouse_pos)
	query.set_hit_from_inside(true)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)
	if result == {}:
		return null
	else:
		return result["collider"]

func create_stack(target):
	if (selected_node != null):
		if (selected_node.occupants[team] > 0):
			var new_stack = stack.instantiate()
			if selected_node.occupants[team] >= selected_size:
				new_stack.size = selected_size
				selected_node.occupants[team] = selected_node.occupants[team] - selected_size
			else:
				new_stack.size = selected_node.occupants[team]
				selected_node.occupants[team] = 0
			new_stack.team = team
			new_stack.target = target
			new_stack.position = selected_node.position
			new_stack.set_color()
			stacks.add_child(new_stack)
			
