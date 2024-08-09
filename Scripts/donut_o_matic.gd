class_name DonutCrate

extends Interactable
signal spawning_donut(item:Donut)

var is_mouse_on_object = false
var donut_scene = preload("res://donut.tscn")
var donut_texture = preload("res://Art/Donuts/Donut_Hole/Standard/Donut_Hole_RAW.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite2D.texture = donut_texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click"):
		if is_mouse_on_object:
			print("clicked on box")
			var donut:Donut = create_donut()
			print(donut)
			Global.is_dragging = true
			Global.item_being_moved = donut
			donut.draggable = true
			donut.scale = Vector2(1.0, 1.0)
			emit_signal("spawning_donut", donut)

func _on_area_2d_mouse_entered():
	if Global.item_being_moved == null:
		print("HOVERED")
		is_mouse_on_object = true



func _on_area_2d_mouse_exited():
	print("NOT HOVERED")
	is_mouse_on_object = false

	
func create_donut() -> Donut:
	var new_donut = donut_scene.instantiate()
	new_donut.position = global_position
	return new_donut
