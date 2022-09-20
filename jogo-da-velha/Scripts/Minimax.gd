extends Node

# export = [SerializeField]

export var game_path: NodePath
var game_manager

var human = -1;
var computer = 1;

func _ready():
	game_manager = get_node(game_path);


func minimax(board, depth, player):
	var empty_cells = game_manager.get_empty_cells(board);
	#var depth = empty_cells.size();
	
	var best;
	if player == computer:
		best = [-1,-1,-999]
	else:
		best = [-1,-1, 999]
	
	var winner = game_manager.check_winner(board);
	if winner != 0 or depth == 0:
		return [-1, -1, winner];
	
	for cell in range (empty_cells.size()):
		var move = empty_cells[cell];
		board[move.x][move.y] = player;
		
		var score = minimax(board, depth -1, -player);
		board[move.x][move.y] = 0;
		score[0] = move.x;
		score[1] = move.y;
		
		if player == computer:
			if score[2] > best [2]:
				best = score #max
		else:
			if score[2] < best [2]:
				best = score #min
	
	return best;
