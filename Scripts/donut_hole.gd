extends Donut


# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()

func update_donut_texture():
	if not is_powdered:
		if (donut_status == Global.DONUT_STATUS.ALMOST_DONE):
			$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Standard/Donut_Hole_ALMOST_DONE.png")
		elif (donut_status == Global.DONUT_STATUS.DONE):
			$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Standard/Donut_Hole_DONE.png")
			donut_type = Global.EOrder_Type.DONUT_HOLE_STD
		elif (donut_status == Global.DONUT_STATUS.BURNED):
			$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Standard/Donut_Hole_BURNT.png")
		elif (donut_status == Global.DONUT_STATUS.RAW):
			$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Standard/Donut_Hole_RAW.png")
	else:
		if donut_status == Global.DONUT_STATUS.RAW:
			match powder_status:
				Global.DONUT_MOD_STATUS.BAD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Bad/Donut_Hole_RAW_POWDERED_BAD.png")
				Global.DONUT_MOD_STATUS.OKAY:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Okay/Donut_Hole_RAW_POWDERED_OKAY.png")
				Global.DONUT_MOD_STATUS.GOOD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Good/Donut_Hole_RAW_POWDERED_GOOD.png")
				Global.DONUT_MOD_STATUS.PERFECT:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Perfect/Donut_Hole_RAW_POWDERED_PERFECT.png")
		elif donut_status == Global.DONUT_STATUS.ALMOST_DONE:
			match powder_status:
				Global.DONUT_MOD_STATUS.BAD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Bad/Donut_Hole_ALMOST_DONE_POWDERED_BAD.png")
				Global.DONUT_MOD_STATUS.OKAY:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Okay/Donut_Hole_ALMOST_DONE_POWDERED_OKAY.png")
				Global.DONUT_MOD_STATUS.GOOD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Good/Donut_Hole_ALMOST_DONE_POWDERED_GOOD.png")
				Global.DONUT_MOD_STATUS.PERFECT:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Perfect/Donut_Hole_ALMOST_DONE_POWDERED_PERFECT.png")
		elif donut_status == Global.DONUT_STATUS.DONE:
			donut_type = Global.EOrder_Type.DONUT_HOLE_POW
			match powder_status:
				Global.DONUT_MOD_STATUS.BAD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Bad/Donut_Hole_DONE_POWDERED_BAD.png")
				Global.DONUT_MOD_STATUS.OKAY:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Okay/Donut_Hole_DONE_POWDERED_OKAY.png")
				Global.DONUT_MOD_STATUS.GOOD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Good/Donut_Hole_DONE_POWDERED_GOOD.png")
				Global.DONUT_MOD_STATUS.PERFECT:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Perfect/Donut_Hole_DONE_POWDERED_PERFECT.png")
		elif donut_status == Global.DONUT_STATUS.BURNED:
			match powder_status:
				Global.DONUT_MOD_STATUS.BAD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Bad/Donut_Hole_BURNT_POWDERED_BAD.png")
				Global.DONUT_MOD_STATUS.OKAY:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Okay/Donut_Hole_BURNT_POWDERED_OKAY.png")
				Global.DONUT_MOD_STATUS.GOOD:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Good/Donut_Hole_BURNT_POWDERED_GOOD.png")
				Global.DONUT_MOD_STATUS.PERFECT:
					$Sprite2D.texture = preload("res://Art/Donuts/Donut_Hole/Powdered/Perfect/Donut_Hole_BURNT_POWDERED_PERFECT.png")
