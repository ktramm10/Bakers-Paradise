class_name OrderPanel

extends TextureRect

var selection
var tag
var quantity


func _init():
	selection = randi_range(1, 2)
	quantity = randi_range(1, 6)

# Called when the node enters the scene tree for the first time.
func _ready():
	match(selection):
		1:
			$order_specifics.texture = preload("res://Art/Donuts/Donut_Hole/Standard/Donut_Hole_DONE.png")
			tag = Global.EOrder_Type.DONUT_HOLE_STD
		2:
			$order_specifics.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Perfect/Donut_Hole_DONE_POWDERED_PERFECT.png")
			tag = Global.EOrder_Type.DONUT_HOLE_POW
	$Quantity.text = str(quantity)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
