extends Node

signal play_again_signal();

func _on_PlayAgain_pressed():
	emit_signal("play_again_signal");

func _on_Exit_pressed():
	pass;
