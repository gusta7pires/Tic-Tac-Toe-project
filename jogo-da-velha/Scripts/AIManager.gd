extends Node

var human = -1;
var computer = 1;

var rng = RandomNumberGenerator.new()

func easy_game(board, player):
	var score;
	var empty_cells = Common.get_empty_cells(board);
	randomize();
	var spot = randi() % empty_cells.size();
	score = empty_cells[spot];
	score[2] = player;
	return score;

func medium_game(board, depth, player):
	var score = [0,0,player]
	if(rng.randi() % 100 < 30):
		score = easy_game(board, player);
	else:
		score = minimax(board, depth, player);
	return score;

func minimax(board, depth, player):
	var empty_cells = Common.get_empty_cells(board);
	
	var best;
	if player == computer:
		best = [-1,-1,-999]
	else:
		best = [-1,-1, 999]
	
	var winner = Common.check_winner_posibilities(board);
	
	if winner != 0:
		var weight = depth + 10;
		return [-1, -1, winner * weight];
	elif depth == 0:
		return [-1 , -1, 0];
	
	for cell in range (empty_cells.size()):
		var chosen_cell = empty_cells[cell];
		board[chosen_cell[0]][chosen_cell[1]] = player;
		var score = minimax(board, depth - 1, -player);
		board[chosen_cell[0]][chosen_cell[1]] = 0;
		score[0] = chosen_cell[0];
		score[1] = chosen_cell[1];
		
		if player == computer:
			if score[2] > best [2]:
				best = score #max
		elif player == human:
			if score[2] < best [2]:
				best = score #min
	
	return best;
