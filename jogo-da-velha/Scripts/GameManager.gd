extends Node

var go_first_screen;
var board_manager;
export var game_over_label_path: NodePath;
var game_over_label;
var game_over_screen;

var board_size = 3;
var board_state = [];

var ai_manager;

var human = -1;
var computer = 1;
var go_first;
var current_player;

var game_end;
signal go_to_main_menu();

func _ready():
	go_first_screen = get_node("GoFirst");
	board_manager = get_node("Tabuleiro");
	game_over_label = get_node(game_over_label_path);
	game_over_screen = get_node("GameOver");
	ai_manager = get_node("AIManager");
	create_board();
	show_go_first_screen();

func create_board():
	for x in range(board_size):
		board_state.append([]);
		for _y in range(board_size):
			board_state[x].append(0);
	board_manager.append_board_nodes();

func new_game():
	go_first_screen.hide();
	board_manager.show();
	game_over_screen.hide();
	current_player = human;
	game_end = false;
	for line in range(board_size):
		for column in range(board_size):
			update_boards(line, column, 0);
	
	if not go_first:
		ai_move(computer);
		go_first = true;


func update_boards(line, column, player):
	board_state[line][column] = player;
	board_manager.board_nodes[line][column].set_player(player);

func _on_Tabuleiro_on_node_clicked(line, column):
	if game_end:
		return;
	
	if Common.get_dificulty() == 3:
		vs_player_move(line, column);
	else:
		vs_cpu_move(line, column);

func vs_player_move(line, column):
	update_boards(line, column, current_player);
	get_winner();
	if(current_player == human):
		current_player = computer;
	else:
		current_player = human;

func vs_cpu_move(line, column):
	if go_first == true:
		player_move(line, column);
	
	if not game_end:
		ai_move(computer);

func player_move(line, column):
	update_boards(line, column, human);
	get_winner();

func ai_move(player):
	var empty_cells = Common.get_empty_cells(board_state);
	var depth = empty_cells.size();
	
	var move = [];
	
	if depth == 9:
		randomize();
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
	
	if(winnig_player == human or winnig_player == computer):
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

func on_game_over():
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

func game_mode_check():
	if Common.get_dificulty() == 3:
		new_game();
	else:
		show_go_first_screen();

func show_go_first_screen():
	go_first_screen.show();
	board_manager.hide();
	game_over_screen.hide();

func _on_PlayAgain_pressed():
	$SoundClick.play();
	game_mode_check();

func _on_MainMenu_pressed():
	$SoundClick.play();
	emit_signal("go_to_main_menu");

func _on_Yes_pressed():
	go_first = true;
	$SoundClick.play();
	new_game();

func _on_No_pressed():
	go_first = false;
	$SoundClick.play();
	new_game();

func _on_SetDificulty_on_dificulty_set():
	game_mode_check();
