class_name HUD

extends Control

signal send_quick_time_data(selection)

@export var time_in_sec = 180

# Called when the node enters the scene tree for the first time.
func _ready():
	$Bar.visible = false
	$Bar/Bar_Selector.visible = false
	$Game_Timer.wait_time = time_in_sec
	$Game_Timer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Score.text = str("Score: ", Global.score)
	$Time_Remaining.text = str(int(convert_time()[0]),":", convert_time()[1])


func convert_time() -> Array:
	var seconds_remaining = $Game_Timer.time_left
	var min = 0.0
	var sec = 0.0
	while seconds_remaining > 0.0:
		if seconds_remaining >= 59.5:
			min += 1.0
			seconds_remaining -= 60.0
		else:
			sec += seconds_remaining
			seconds_remaining = 0.0
	if sec < 9.5:
		var sec_format = "0%.f"
		sec = sec_format % sec
		print(sec)
	else:
		var sec_format = "%.f"
		sec = sec_format % sec
	return [str(min), sec]


func _on_bar_selector_send_color_selection(selection):
	emit_signal("send_quick_time_data", selection)
	
	
func toggle_quicktime_visibility():
	$Bar.visible = not $Bar.visible
	$Bar/Bar_Selector.visible = not $Bar/Bar_Selector.visible
