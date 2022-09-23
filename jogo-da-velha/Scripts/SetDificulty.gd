extends Node

signal on_dificulty_set();

func _on_vs_player_pressed():
	Common.set_dificulty(3);
	$SoundClick.play();
	emit_signal("on_dificulty_set");

func _on_Easy_pressed():
	Common.set_dificulty(0);
	$SoundClick.play();
	emit_signal("on_dificulty_set");

func _on_Medium_pressed():
	Common.set_dificulty(1);
	$SoundClick.play();
	emit_signal("on_dificulty_set");

func _on_Hard_pressed():
	Common.set_dificulty(2);
	$SoundClick.play();
	emit_signal("on_dificulty_set");
