extends Node

var board_manager;

export var game_over_label_path: NodePath;
var game_over_label;

var board_size = 3;
var board_state = [];

var ai_manager;

var player1 = -1;
var player2 = 1;

var current_player;
signal on_player_change(player);

var game_end;
var game_over_screen;

signal go_to_main_menu();

func _ready():
	board_manager = get_node("Tabuleiro");
	game_over_label = get_node(game_over_label_path);
	game_over_screen = get_node("GameOver");
	ai_manager = get_node("AIManager");
	create_board();
	new_game();

func create_board():
	for x in range(board_size):
		board_state.append([]);
		for _y in range(board_size):
			board_state[x].append(0);
	board_manager.append_board_nodes();
	#print_board();

func new_game():
	board_manager.show();
	game_over_screen.hide();
	current_player = player1;
	emit_signal("on_player_change", current_player);
	game_end = false;
	for line in range(board_size):
		for column in range(board_size):
			update_boards(line, column, 0);
	#board_manager.reset_board();
	print_board();

func update_boards(line, column, player):
	board_state[line][column] = player;
	board_manager.board_nodes[line][column].set_player(player);

func _on_Tabuleiro_on_node_clicked(line, column):
	if Common.get_dificulty() == 3:
		vs_player_move(line, column);
	else:
		vs_cpu_move(line, column);

func vs_player_move(line, column):
	update_boards(line, column, current_player);
	get_winner();
	if(current_player == player1):
		current_player = player2;
	else:
		current_player = player1;
	emit_signal("on_player_change", current_player, game_end);

func vs_cpu_move(line, column):
	emit_signal("on_player_change", player1, game_end);
	update_boards(line, column, player1);
	get_winner();
	
	if not game_end:
		emit_signal("on_player_change", player2, game_end);
		ai_move(player2);
	
	print_board();

func ai_move(player):
	var empty_cells = Common.get_empty_cells(board_state);
	var depth = empty_cells.size();
	
	var move = [];
	
	if depth == 9:
		var spot = randi() % empty_cells.size();
		move = empty_cells[spot];
	else:
		var dif = Common.get_dificulty();
		match dif:
			0:
				move = ai_manager.easy_game(board_state, player);
			1:
				move = ai_manager.medium_game(board_state, depth, player);
			2:
				move = ai_manager.minimax(board_state, depth, player);
	
	print(move);
	print();
	
	update_boards(move[0], move[1], player);
	get_winner();

func get_winner():
	var winnig_player = Common.check_winner_posibilities(board_state);
	
	if(winnig_player == player1 or winnig_player == player2):
		game_end = true;
		current_player = winnig_player;
		print("Jogador %d vanceu" % winnig_player);
		
		if Common.get_dificulty() == 3:
			vs_player_winnig_text(winnig_player);
		else:
			vs_cpu_winning_text(winnig_player);
		
		on_game_over();
		return;
	
	if(Common.check_empty_positions(board_state)==0):
		game_end = true;
		print("Deu Velha!");
		game_over_label.text = "Draw";
		on_game_over();
		return;

func print_board():
	for x in range(board_state.size()):
		print(board_state[x])
	print()

func on_game_over():
	board_manager.hide();
	game_over_screen.show();

func vs_player_winnig_text(player):
	if player == -1:
		player = 1;
	elif player == 1:
		player = 2;
	var string = "Player %d win!" % player;
	game_over_label.text = string;

func vs_cpu_winning_text(player):
	var string;
	if(player == -1):
		game_over_label.text = "You win!";
	if(player == 1):
		game_over_label.text = "You loose!";

func _on_PlayAgain_pressed():
	new_game();

func _on_MainMenu_pressed():
	new_game();
	emit_signal("go_to_main_menu");
