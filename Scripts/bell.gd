class_name Bell
extends Interactable

signal sell_donuts

var is_mouse_on_object = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_mouse_on_object:
		if Input.is_action_just_pressed("click"):
			emit_signal("sell_donuts")


func _on_area_2d_mouse_entered():
	if Global.item_being_moved == null:
		is_mouse_on_object = true
		


func _on_area_2d_mouse_exited():
	is_mouse_on_object = false
