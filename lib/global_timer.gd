extends Timer
## A singleton made specifically for Retractable Spike to solve
## desyncronization issue. Strictly one second duration.


func _init() -> void:
	autostart = true
