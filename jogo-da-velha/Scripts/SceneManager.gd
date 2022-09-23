extends Node

export var menu_path: NodePath;
export var set_dificulty_path: NodePath;
export var game_path: NodePath;

var menu_screen;
var set_dificulty_screen;
var game_screen;

func _ready():
	menu_screen = get_node(menu_path);
	set_dificulty_screen = get_node(set_dificulty_path);
	game_screen = get_node(game_path);
	
	main_menu();

func main_menu():
	menu_screen.show();
	set_dificulty_screen.hide();
	game_screen.hide();

func set_dificulty():
	menu_screen.hide();
	set_dificulty_screen.show();
	game_screen.hide();

func start_game():
	menu_screen.hide();
	set_dificulty_screen.hide();
	game_screen.new_game();
	game_screen.show();

func game_over():
	menu_screen.hide();
	set_dificulty_screen.hide();
	game_screen.hide();

func _on_MainMenu_on_start():
	set_dificulty();

func _on_SetDificulty_on_dificulty_set():
	start_game();

func _on_Game_on_game_over():
	game_over()

func _on_Game_Over_play_again_signal():
	set_dificulty();

func _on_Game_go_to_main_menu():
	main_menu();
