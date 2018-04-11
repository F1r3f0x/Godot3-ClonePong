extends Label

signal finished

onready var animations = $Animations

func show_off():
	animations.play("show_off")
	yield(animations,"animation_finished")
	emit_signal("finished")
	
func fade():
	animations.play("fade_out")
	yield(animations,"animation_finished")
	emit_signal("finished")