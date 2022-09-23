extends Node

signal on_dificulty_set();

func play_click_sound():
	get_node("SoundClick").play();

func _on_vs_player_pressed():
	Common.set_dificulty(3);
	play_click_sound();
	emit_signal("on_dificulty_set");

func _on_Easy_pressed():
	Common.set_dificulty(0);
	play_click_sound();
	emit_signal("on_dificulty_set");

func _on_Medium_pressed():
	Common.set_dificulty(1);
	play_click_sound();
	emit_signal("on_dificulty_set");

func _on_Hard_pressed():
	Common.set_dificulty(2);
	play_click_sound();
	emit_signal("on_dificulty_set");
