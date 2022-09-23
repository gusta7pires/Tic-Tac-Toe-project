extends Node

var dificulty : int;
# 0 = easy, 1 = medium, 2 = hard, 3 = vs player

func _ready():
	dificulty = 3;

func get_dificulty():
	return dificulty;

func set_dificulty(dificulty):
	self.dificulty = dificulty;

func get_empty_cells(board):
	var empty_cells = [];
	for line in range (board.size()):
		for column in range (board.size()):
			if(board[line][column]==0):
				empty_cells.append([line, column, 0]);
	return empty_cells;

func check_empty_positions(current_board):
	var empty_positions = 0;
	for line in range  (current_board.size()):
		for column in range (current_board.size()):
			if (current_board[line][column] == 0):
				empty_positions += 1;
	
	return empty_positions;

func check_winner_posibilities(board):
	for player in [-1, 1]:
		for line in range (board.size()):
			if(check_line(line, player, board)):
				return player;
		
		for column in range(board.size()):
			if(check_column(column, player, board)):
				return player;
		
		for diagonal in [0,2]:
			if(check_diagonal(diagonal, player, board)):
				return player;
	
	return 0;

func check_line(line, player, current_board):
	for column in range(current_board.size()):
		if (current_board[line][column] != player):
			return false;
	return true;

func check_column(column, player, current_board):
	for line in range(current_board.size()):
		if (current_board[line][column] != player):
			return false;
	return true;

func check_diagonal(diagonal, player, current_board):
	for line in range(current_board.size()):
		var column;
		if(diagonal == 0):
			column = line;
		else:
			column = current_board.size() - line - 1;
		
		if (current_board[line][column] != player):
			return false;
	return true;
