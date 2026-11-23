extends Timer
## A singleton made specifically for Retractable Spike and Spike Cannon 
## to solve desyncronization issue. Strictly one second duration.


func _init() -> void:
	autostart = true
