extends Node

signal on_start();

func play_click_sound():
	get_node("SoundClick").play();

func _on_Start_pressed():
	play_click_sound();
	emit_signal("on_start");

func _on_Exit_pressed():
	play_click_sound();
	get_tree().quit();
