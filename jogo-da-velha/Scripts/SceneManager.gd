extends Node

export var menu_path: NodePath;
export var set_dificulty_path: NodePath;
export var game_path: NodePath;
export var game_over_path: NodePath;

var menu;
var set_dificulty;
var game;
var game_over;

func _ready():
	menu = get_node(menu_path);
	set_dificulty = get_node(set_dificulty_path);
	game = get_node(game_path);
	game_over = get_node(game_over_path);
	
	main_menu();

func main_menu():
	menu.show();
	set_dificulty.hide();
	game.hide();

func set_dificulty():
	menu.hide();
	set_dificulty.show();
	game.hide();

func start_game():
	menu.hide();
	set_dificulty.hide();
	game.show();

func game_over():
	menu.hide();
	set_dificulty.hide();
	game.hide();

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
