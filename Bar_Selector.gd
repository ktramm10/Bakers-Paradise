extends TextureRect

enum EColors{Green, Yellow, Orange, Red}

signal send_color_selection(selection)

@export var modulation_distance = 0
var position_ref
var speed = 85
var left = true
var selection


# Called when the node enters the scene tree for the first time.
func _ready():
	position_ref = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		print("pos ref x - : ", position_ref.x - modulation_distance)
		print("pos ref x + : ", position_ref.x + modulation_distance)
		print("pos ref x : ", position_ref.x)
		print("pos: ", position.x)
		if position.x < position_ref.x - modulation_distance:
			left = true
		elif position.x > position_ref.x + modulation_distance:
			left = false
		if left:
			position.x += speed * delta
		else:
			position.x -= speed * delta
			
		if Input.is_action_just_pressed("click"):
			selection = get_selection(abs(position.x))
			visible = false
			get_parent().visible = false
			emit_signal("send_color_selection", selection)
			print(selection)
	else:
		position = position_ref
		
func get_selection(pos_x) -> EColors:
	
	var this_selection
	
	if pos_x > 20 && pos_x < 31:
		this_selection = EColors.Red
		
	elif pos_x > 13 && pos_x < 20:
		this_selection = EColors.Orange
		
	elif pos_x > 4 && pos_x < 13:
		this_selection = EColors.Yellow
		
	else:
		this_selection = EColors.Green
		
	return this_selection
	
