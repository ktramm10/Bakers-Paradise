extends DonutCrate

func _ready():
	donut_scene = preload("res://yeast_donut.tscn")
	donut_texture = preload("res://Art/Donuts/Yeast_Donut/Standard/Yeast_Donut_STD_RAW.png")
	$Sprite2D.scale = Vector2(0.5, 0.5)
	super._ready()
