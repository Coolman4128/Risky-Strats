extends Node2D

#VARIABLES
var stack_id = 0
var size = 0
var team = ""
var target = null
var SPEEDCOEFF = 100

# Nodes
var label = null
var sprite = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label = $Label
	sprite = $Sprite2D
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	find_label()
	sprite.scale = Vector2( sqrt(size/10000), sqrt(size/10000))
	if target == null:
		pass
	else:
		position = Vector2(move_toward(position.x, target.position.x, SPEEDCOEFF / size), move_toward(position.y, target.position.y, SPEEDCOEFF / size))

func find_label():
	label.set_text(str(size))
	
func set_color():
	modulate = Globals.factionColorDict[team]
