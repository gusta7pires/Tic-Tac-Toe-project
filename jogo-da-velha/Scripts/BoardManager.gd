extends Node2D

signal on_node_clicked(line, column);

export var game_manager_path: NodePath;

var board_size = 3;

var board_nodes;

func append_board_nodes():
	board_nodes = [];
	for line in range (board_size):
		board_nodes.append([]);
		for column in range(board_size):
			var node = get_node("%d-%d" % [line, column]);
			node.set_board(self, line, column);
			board_nodes[line].append(node);

func node_clicked(line, column):
	if (board_nodes[line][column].get_player() != 0):
		
		return;
	
	emit_signal("on_node_clicked", line, column);

func reset_board():
	for line in range (board_size):
		for column in range(board_size):
		 board_nodes[line][column].set_player(0);

func set_node(line, column, player):
	board_nodes[line][column].set_player(player);
