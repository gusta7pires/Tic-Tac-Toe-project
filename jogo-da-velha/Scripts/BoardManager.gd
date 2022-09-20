extends Node2D

signal on_node_clicked(line, column);
#signal check_game_over;

export var game_manager_path: NodePath;
var game_manager;

var board_size = 3;

var board_nodes;
var current_player;
var game_end;

var manager;

func _ready():
	game_manager = get_node(game_manager_path);

func append_board_nodes():
	board_nodes = [];
	for line in range (board_size):
		board_nodes.append([]);
		for column in range(board_size):
			var node = get_node("%d-%d" % [line, column]);
			node.set_board(self, line, column);
			board_nodes[line].append(node);

func node_clicked(line, column):
	#emit_signal("check_game_over");
	
	if (board_nodes[line][column].get_player() != 0):
		#set_player(player);
		return;
	
	emit_signal("on_node_clicked", line, column);

func reset_board():
	for line in range (board_size):
		for column in range(board_size):
		 board_nodes[line][column].set_player(0);

func set_node(line, column, player):
	board_nodes[line][column].set_player(player);

func _on_Game_on_player_change(player):
	current_player = player;
	print("changed");
