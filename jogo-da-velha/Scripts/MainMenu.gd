extends Node

signal on_start();

func _on_Start_pressed():
	$SoundClick.play();
	emit_signal("on_start");

func _on_Exit_pressed():
	$SoundClick.play();
	get_tree().quit();
