extends Node2D



#VARIABLES
var node_id = 0
var connections = []
var occupants = {}

# Nodes
var label = null
var sprite = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label = $Label
	sprite = $Sprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	find_color()
	find_label()

func find_label():
	if len(occupants) == 0:
		label.set_text("")
		return
	var new_text = ""
	for key in occupants.keys():
		new_text = new_text + key + ": " + str(occupants[key]) + "\n"
	label.set_text(new_text)
		
	

func find_color():
	if len(occupants) == 0:
		modulate = Color(.1,.1,.1,1)
		return
	if len(occupants) == 1:
		modulate = Globals.factionColorDict[occupants.keys()[0]]
		return
	var colorList = []
	for key in occupants.keys():
		colorList.append(Globals.factionColorDict[key])
	modulate = average_colors(colorList)
	
func average_colors(colorList):
	var tempr = 0
	var tempb = 0
	var tempg = 0
	for color in colorList:
		tempr = tempr + color.r
		tempb = tempb + color.b
		tempg = tempg + color.g
	return Color(tempr/len(colorList), tempg/len(colorList), tempb/len(colorList), 1)
	
