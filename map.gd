extends Node2D

#VARIBLES


#INSTANCES
var map_node = preload("res://city_node.tscn")


#NODES
var map_nodes = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	map_nodes = $map_nodes
	create_new_node(Vector2(100,100), [], {"red": 1000})
	create_new_node(Vector2(200,100), [], {"blue": 1000})
	create_new_node(Vector2(100,200), [], {"blue": 1000})

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func create_new_node(pos, connections, occupants = {}):
	var new_node = map_node.instantiate()
	new_node.position = pos
	new_node.connections = connections
	new_node.occupants = occupants
	new_node.node_id = len(map_nodes.get_children()) + 1
	map_nodes.add_child(new_node)
