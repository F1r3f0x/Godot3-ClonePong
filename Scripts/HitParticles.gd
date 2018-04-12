# HitParticles Script
# F1r3f0x - 2018
extends Particles2D


# Destroy particle emitter after animation
func _on_Timer_timeout():
	queue_free()