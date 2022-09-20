extends Node

signal on_start();

func _on_Start_pressed():
	emit_signal("on_start");

func _on_Exit_pressed():
	pass;
