extends Label

signal finished


func show_off():
	$Animations.play("show_off")
	yield($Animations,"animation_finished")
	emit_signal("finished")
	
func fade():
	$Animations.play("fade_out")
	yield($Animations,"animation_finished")
	emit_signal("finished")