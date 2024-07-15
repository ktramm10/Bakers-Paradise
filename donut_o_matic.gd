class_name Donut_O_Matic

extends Interactable

signal spawning_donut

var is_mouse_on_object = false
var donut_scene = preload("res://donut.tscn")
var donut_capacity
var donuts_left


# Called when the node enters the scene tree for the first time.
func _ready():
	donut_capacity = 3
	donuts_left = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if donuts_left < donut_capacity && $Donut_Recharge.is_stopped():
		$Donut_Recharge.start()
	elif donuts_left == donut_capacity:
		$Donut_Recharge.stop()
		
	if Input.is_action_just_pressed("click"):
		if is_mouse_on_object && donuts_left > 0:
			var donut:Donut = create_donut()
			Global.is_dragging = true
			Global.item_being_moved = donut
			donut.draggable = true
			donut.scale = Vector2(1.0, 1.0)
			emit_signal("spawning_donut", donut)
			donuts_left -= 1
			
	match donuts_left:
		0:
			$Sprite2D.texture = preload("res://Art/Donut_O_Matic/Donut_O_Matic_Cap3_NoLights.png")
		1:
			$Sprite2D.texture = preload("res://Art/Donut_O_Matic/Donut_O_Matic_Cap3_1Light.png")
		2:
			$Sprite2D.texture = preload("res://Art/Donut_O_Matic/Donut_O_Matic_Cap3_2Light.png")
		3:
			$Sprite2D.texture = preload("res://Art/Donut_O_Matic/Donut_O_Matic_Cap3_3Light.png")
	
	

func _on_area_2d_mouse_entered():
	print("mouse entered")
	if Global.item_being_moved == null:
		is_mouse_on_object = true
		



func _on_area_2d_mouse_exited():
	print("mouse exited")
	is_mouse_on_object = false

	
func create_donut() -> Donut:
	var new_donut = donut_scene.instantiate()
	new_donut.position = global_position
	return new_donut




func _on_donut_recharge_timeout():
	donuts_left += 1
